import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/categories/categories_display_cubit.dart';
import 'package:locally/common/bloc/categories/categories_display_state.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/presentation/category_products/pages/category_products.dart';

class AllCategoriesPage extends StatelessWidget {
  const AllCategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => CategoriesDisplayCubit()..displayCategories(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Shop by Categories',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 22,
                    color: AppColors.text,
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(child: _categoriesList()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _categoriesList() {
    return BlocBuilder<CategoriesDisplayCubit, CategoriesDisplayState>(
      builder: (context, state) {
        if (state is CategoriesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state is CategoriesLoaded) {
          return ListView.separated(
            itemCount: state.categories.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final category = state.categories[index];
              return _CategoryItem(category: category);
            },
          );
        }

        return const SizedBox();
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final dynamic category;

  const _CategoryItem({required this.category});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          CategoryProductsPage(categoryEntity: category),
        );
      },
      child: Container(
        height: 70,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            ClipOval(
              child: Image.network(
                category.image,
                height: 50,
                width: 50,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  height: 50,
                  width: 50,
                  color: Colors.grey.shade300,
                  child: const Icon(Icons.image_not_supported, color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Text(
                category.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: AppColors.text,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.text,
            )
          ],
        ),
      ),
    );
  }
}
