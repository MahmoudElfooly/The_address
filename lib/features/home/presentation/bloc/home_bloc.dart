import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/features/home/domain/entities/category_entituy.dart';
import 'package:the_address/features/home/domain/entities/product_entity.dart';
import 'package:the_address/features/productDetails/data/models/update_product_payload.dart';

import '../../../productDetails/domain/useCase/product_use_case.dart';
import '../../domain/useCase/home_use_case.dart';
import 'home_events.dart';
import 'home_states.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HomeUseCase _homeUseCase;
  final ProductUseCase _productUseCase;

  final int limit = 10;
  List<ProductItemEntity> products = [];
  List<CategoryItemEntity> categories = [];
  int currentPage = 1;
  bool isFetching = false; // Prevent duplicate requests

  HomeBloc(this._homeUseCase, this._productUseCase) : super(HomeInitial()) {
    on<LoadHomeData>(_onLoadHomes);
    on<LoadMoreProducts>(_onLoadMoreProducts);
    on<UpdateProductEvent>(_onUpdateProduct);
  }

  Future<void> _onLoadHomes(LoadHomeData event, Emitter<HomeState> emit) async {
    emit(HomeLoading());
    products = await _homeUseCase.getProducts(offset: 0, limit: limit);
    categories = await _homeUseCase.getCategories();
    emit(HomeLoaded(
        categories: categories,
        products: products,
        hasMore: products.isNotEmpty));
  }

  Future<void> _onLoadMoreProducts(
      LoadMoreProducts event, Emitter<HomeState> emit) async {
    if (state is! HomeLoaded || isFetching) return;

    final currentState = state as HomeLoaded;
    isFetching = true; // Prevent duplicate requests

    try {
      currentPage++;
      final newProducts =
          await _homeUseCase.getProducts(offset: currentPage, limit: limit);
      isFetching = false;

      emit(HomeLoaded(
        categories: currentState.categories,
        products: [...currentState.products, ...newProducts],
        hasMore: newProducts.isNotEmpty,
      ));
    } catch (e) {
      isFetching = false;
      emit(HomeError(e.toString()));
    }
  }

  Future<void> _onUpdateProduct(
      UpdateProductEvent event, Emitter<HomeState> emit) async {
    if (state is! HomeLoaded) return;
    final currentState = state as HomeLoaded;

    final success = await _productUseCase.updateProduct(
        id: event.product.id,
        payload: UpdateProductPayload(
            title: event.product.title,
            price: event.product.price,
            images: event.product.images));

    if (success) {
      // Update the local product list
      final updatedProducts = currentState.products.map((product) {
        if (product.id == event.product.id) {
          return product.copyWith(
              title: event.product.title,
              price: event.product.price); // Modify as needed
        }
        return product;
      }).toList();

      emit(HomeLoaded(
        categories: currentState.categories,
        products: updatedProducts,
        hasMore: currentState.hasMore,
      ));
    }
  }
}
