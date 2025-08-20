import 'package:flutter/material.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import '../../../domain/product/entities/product.dart';

class ProductTitle extends StatelessWidget {
  final ProductEntity productEntity;
  final double fontSize;
  final FontWeight fontWeight;
  final int maxLines;

  const ProductTitle({
    required this.productEntity,
    this.fontSize = 16,
    this.fontWeight = FontWeight.bold,
    this.maxLines = 2,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final title = (productEntity.title.isNotEmpty)
        ? productEntity.title
        : 'No title available';

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: fontWeight,
          fontSize: fontSize,
          color: AppColors.text,
        ),
        maxLines: maxLines,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}
