import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/bloc/categories/categories_display_cubit.dart';
import 'package:locally/common/bloc/categories/categories_display_state.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/category/entity/category.dart';
import 'package:locally/presentation/navigation/bloc/navigation_cubit.dart';

class Categories extends StatelessWidget {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesDisplayCubit()..displayCategories(),
      child: BlocBuilder<CategoriesDisplayCubit,CategoriesDisplayState>(
        builder: (context,state) {
          if (state is CategoriesLoading) {
            return const CircularProgressIndicator();
          }
          if (state is CategoriesLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _seeAll(context),
                const SizedBox(height: 20, ),
                _categoriesList(state.categories)
              ],
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Widget _seeAll(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: AppColors.text,
            ),
          ),
          GestureDetector(
            onTap: () => context.read<NavigationCubit>().changeTab(1),
            child: const Text(
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

  Widget _categoriesList(List<CategoryEntity> categories) {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 15),
        itemBuilder: (context, index) {
          final category = categories[index];
          return Column(
            children: [
              ClipOval(
                child: Image.network(
                  category.image,
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 60,
                    width: 60,
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported, color: Colors.grey),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: 60,
                child: Text(
                  category.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: AppColors.text,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}