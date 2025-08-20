import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/product_detail/widgets/product_sizes.dart';
import '../../../common/helper/bottomsheet/app_bottomsheet.dart';
import '../bloc/product_size_selection_cubit.dart';

class SelectedSize extends StatelessWidget {
  final ProductEntity productEntity;
  const SelectedSize({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: () {
        AppBottomSheet.display(
          context,
          BlocProvider.value(
            value: BlocProvider.of<ProductSizeSelectionCubit>(context),
            child: ProductSizes(productEntity: productEntity),
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
              'Size',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14,
                color: AppColors.text,
              ),
            ),
            Flexible(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<ProductSizeSelectionCubit, int>(
                    builder: (context, state) {
                      final sizes = productEntity.sizes;
                      String sizeText = 'No sizes available';

                      if (sizes.isNotEmpty && state >= 0 && state < sizes.length) {
                        sizeText = sizes[state];
                      }

                      return Text(
                        sizeText,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.text,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      );
                    },
                  ),
                  const SizedBox(width: 15),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 30,
                    color: AppColors.text,
                    semanticLabel: 'Select size',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
