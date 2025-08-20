import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/product/products_display_cubit.dart';
import 'package:locally/common/bloc/product/products_display_state.dart';
import 'package:locally/common/widgets/product/product_card.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/domain/product/usecases/get_top_selling.dart';
import 'package:locally/service_locator.dart';

class TopSelling extends StatelessWidget {
  const TopSelling({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
      ProductsDisplayCubit(useCase: sl<GetTopSellingUseCase>())
        ..displayProducts(),
      child: BlocBuilder<ProductsDisplayCubit, ProductsDisplayState>(
        builder: (context, state) {
          if (state is ProductsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ProductsLoaded) {
            if (state.products.isEmpty) {
              return const Padding(
                padding: EdgeInsets.all(16),
                child: Text('No top selling products available.'),
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _sectionHeader(
                  title: 'Top Selling',
                  onSeeAll: () {},
                ),
                const SizedBox(height: 20),
                _productsList(state.products),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _sectionHeader({required String title, VoidCallback? onSeeAll}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.text,
            ),
          ),
          GestureDetector(
            onTap: onSeeAll,
            child: Text(
              'See All',
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _productsList(List<ProductEntity> products) {
    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ProductCard(productEntity: products[index]);
        },
        separatorBuilder: (_, __) => const SizedBox(width: 10),
      ),
    );
  }
}
