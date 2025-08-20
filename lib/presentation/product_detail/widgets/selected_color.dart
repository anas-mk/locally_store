import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/common/helper/bottomsheet/app_bottomsheet.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/product_detail/bloc/product_color_selection_cubit.dart';
import 'package:locally/presentation/product_detail/widgets/product_colors.dart';
import 'package:locally/domain/product/entities/color_extension.dart'; // مهم!

class SelectedColor extends StatelessWidget {
  final ProductEntity productEntity;

  const SelectedColor({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppBottomSheet.display(
          context,
          BlocProvider.value(
            value: BlocProvider.of<ProductColorSelectionCubit>(context),
            child: ProductColors(productEntity: productEntity),
          ),
        );
      },
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Color',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.text,
              ),
            ),
            Row(
              children: [
                BlocBuilder<ProductColorSelectionCubit, int>(
                  builder: (context, state) {
                    Color displayColor = Colors.transparent;

                    if (state >= 0 && state < productEntity.colors.length) {
                      displayColor = productEntity.colors[state].toColor();
                    }

                    return Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                        color: displayColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.grey.shade400),
                      ),
                    );
                  },
                ),
                const SizedBox(width: 15),
                const Icon(
                  Icons.keyboard_arrow_down,
                  size: 30,
                  color: AppColors.text,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
