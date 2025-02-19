import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:the_address/features/home/domain/useCase/home_use_case.dart';
import 'package:the_address/features/productDetails/domain/useCase/product_use_case.dart';

import '../../../../commonComponents/widgets/cart_icon.dart';
import '../../../../core/servicesLocator/services_locator.dart';
import '../bloc/home_bloc.dart';
import '../bloc/home_events.dart';
import '../bloc/home_states.dart';
import '../widgets/category_chip.dart';
import '../widgets/product_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return BlocProvider(
      create: (context) =>
          HomeBloc(locator<HomeUseCase>(), locator<ProductUseCase>())
            ..add(LoadHomeData()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Image.asset(
            'assets/Logo.png',
            width: 200,
            height: 200,
          ),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: CartIcon(),
            ),
          ],
        ),
        body: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              scrollController.addListener(() {
                if (scrollController.position.pixels ==
                    scrollController.position.maxScrollExtent) {
                  context.read<HomeBloc>().add(LoadMoreProducts());
                }
              });

              return SingleChildScrollView(
                controller: scrollController,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Categories Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: state.categories.length,
                        itemBuilder: (context, index) {
                          return CategoryChip(
                              category: state.categories[index]);
                        },
                      ),
                    ),

                    // Products Section
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Products',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8.0,
                          mainAxisSpacing: 5.0,
                          childAspectRatio: 0.6,
                        ),
                        itemCount: state.products.length,
                        itemBuilder: (context, index) {
                          return ProductCard(
                            product: state.products[index],
                            bloc: context.read(),
                          );
                        },
                      ),
                    ),
                    state.hasMore
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: const Center(
                                child: CircularProgressIndicator()),
                          )
                        : const SizedBox()
                  ],
                ),
              );
            } else if (state is HomeError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const Center(child: Text('No data available'));
            }
          },
        ),
      ),
    );
  }
}
