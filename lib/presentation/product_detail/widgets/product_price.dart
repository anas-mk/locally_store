import 'package:flutter/material.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';

class ProductPrice extends StatelessWidget {
  final ProductEntity productEntity;
  final double fontSize;
  final FontWeight fontWeight;

  const ProductPrice({
    required this.productEntity,
    this.fontSize = 14,
    this.fontWeight = FontWeight.bold,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final price = productEntity.price > 0 ? productEntity.price : 0;
    final discountedPrice = productEntity.discountedPrice > 0
        ? productEntity.discountedPrice
        : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            "\$${(discountedPrice ?? price).toStringAsFixed(2)}",
            style: TextStyle(
              fontWeight: fontWeight,
              color: AppColors.primary,
              fontSize: fontSize,
            ),
          ),
          if (discountedPrice != null)
            Padding(
              padding: const EdgeInsets.only(left: 8),
              child: Text(
                "\$${price.toStringAsFixed(2)}",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: fontSize - 2,
                  decoration: TextDecoration.lineThrough,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
