import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/product_detail/bloc/product_color_selection_cubit.dart';

class ProductColors extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductColors({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.background,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 40,
            child: Stack(
              children: [
                const Center(
                  child: Text(
                    'Color',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: AppColors.text,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close, color: AppColors.text),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return BlocBuilder<ProductColorSelectionCubit, int>(
                  builder: (context, state) {
                    return ProductColorItem(
                      index: index,
                      selectedIndex: state,
                      productEntity: productEntity,
                    );
                  },
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 20),
              itemCount: productEntity.colors.length,
            ),
          ),
        ],
      ),
    );
  }
}

class ProductColorItem extends StatelessWidget {
  final int index;
  final int selectedIndex;
  final ProductEntity productEntity;

  const ProductColorItem({
    required this.index,
    required this.selectedIndex,
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colorData = productEntity.colors[index];
    final hex = colorData.hexCode;

    final color = hex.length >= 3
        ? Color.fromRGBO(
      int.tryParse(hex[0]) ?? 1,
      int.tryParse(hex[1]) ?? 0,
      int.tryParse(hex[2]) ?? 0,
      1,
    )
        : Colors.red;

    final isSelected = selectedIndex == index;

    return GestureDetector(
      onTap: () {
        context.read<ProductColorSelectionCubit>().itemSelection(index);
        Navigator.pop(context);
      },
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : AppColors.secondBackground,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              colorData.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: AppColors.text,
              ),
            ),
            Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 15),
                isSelected
                    ? const Icon(Icons.check, size: 30, color: AppColors.text)
                    : const SizedBox(width: 30),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
