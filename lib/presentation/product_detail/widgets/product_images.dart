import 'package:flutter/material.dart';
import 'package:locally/domain/product/entities/product.dart';

class ProductImages extends StatelessWidget {
  final ProductEntity productEntity;

  const ProductImages({
    required this.productEntity,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<String> images = (productEntity.images.isNotEmpty)
        ? productEntity.images
        : ['https://via.placeholder.com/300'];

    return SizedBox(
      height: 300,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: images.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final imageUrl = images[index];

          return ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FadeInImage.assetNetwork(
              placeholder: 'assets/images/placeholder.png',
              image: imageUrl,
              fit: BoxFit.cover,
              width: 200,
              imageErrorBuilder: (context, error, stackTrace) {
                return Image.asset(
                  'assets/images/placeholder.png',
                  fit: BoxFit.cover,
                  width: 200,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
