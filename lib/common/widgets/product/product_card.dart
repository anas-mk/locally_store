import 'package:flutter/material.dart';
import 'package:locally/common/helper/navigator/app_navigator.dart';
import 'package:locally/core/configs/theme/app_colors.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/presentation/product_detail/pages/product_detail.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductCard({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String displayPrice = productEntity.discountedPrice == 0
        ? "${productEntity.price}\$"
        : "${productEntity.discountedPrice}\$";

    final String? originalPrice = productEntity.discountedPrice != 0
        ? "${productEntity.price}\$"
        : null;

    return GestureDetector(
      onTap: () {
        AppNavigator.push(
          context,
          ProductDetailPage(productEntity: productEntity),
        );
      },
      child: Container(
        width: 180,
        decoration: BoxDecoration(
          color: AppColors.secondBackground,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 235,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
                child: Image.network(
                  productEntity.images.isNotEmpty
                      ? productEntity.images[0]
                      : 'https://via.placeholder.com/150',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(child: CircularProgressIndicator(strokeWidth: 2));
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    productEntity.title,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w300,
                      color: AppColors.text,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        displayPrice,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: AppColors.text,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (originalPrice != null) ...[
                        const SizedBox(width: 10),
                        Text(
                          originalPrice,
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                            fontWeight: FontWeight.w300,
                            decoration: TextDecoration.lineThrough,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ],
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

