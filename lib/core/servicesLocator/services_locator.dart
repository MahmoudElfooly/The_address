import 'package:get_it/get_it.dart';
import 'package:the_address/features/home/data/repositoryImp/home_repo_imp.dart';
import 'package:the_address/features/home/domain/mapper/categories_mapper.dart';
import 'package:the_address/features/home/domain/mapper/products_mapper.dart';
import 'package:the_address/features/home/domain/repository/home_repository.dart';
import 'package:the_address/features/home/domain/useCase/home_use_case.dart';
import 'package:the_address/features/productDetails/domain/mapper/product_to_cart_mapper.dart';
import 'package:the_address/features/productDetails/domain/repository/product_repo.dart';

import '../../features/cart/data/repositoryImp/cart_repo_imp.dart';
import '../../features/cart/domain/repository/cart_repo.dart';
import '../../features/cart/domain/useCase/cart_use_case.dart';
import '../../features/productDetails/data/repositoryImp/product_repo_imp.dart';
import '../../features/productDetails/domain/useCase/product_use_case.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Mappers
  locator.registerSingleton<ProductMapper>(ProductMapperImp());
  locator.registerSingleton<CategoryMapper>(CategoryMapperImp());
  locator
      .registerSingleton<ProductToCartItemMapper>(ProductToCartItemMapperImp());

  //Repos
  locator.registerSingleton<HomeRepository>(HomeRepositoryImp());
  locator.registerSingleton<CartRepository>(CartRepositoryImp());
  locator.registerSingleton<ProductRepository>(ProductRepositoryImp());
  //Use Case
  locator.registerSingleton<HomeUseCase>(HomeUseCaseImp(
      locator<HomeRepository>(),
      locator<ProductMapper>(),
      locator<CategoryMapper>()));
  locator.registerSingleton<CartUseCase>(
      CartUseCaseImp(locator<CartRepository>()));
  locator.registerSingleton<ProductUseCase>(
      ProductUseCaseImp(locator<ProductRepository>()));
}
