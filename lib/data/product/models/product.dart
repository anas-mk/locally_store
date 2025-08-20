import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locally/data/product/models/color.dart';
import 'package:locally/domain/product/entities/product.dart';

class ProductModel {
  final String categoryId;
  final List<ProductColorModel> colors;
  final Timestamp createdDate;
  final double discountedPrice;
  final int gender;
  final List<String> images;
  final double price;
  final List<String> sizes;
  final String productId;
  final int salesNumber;
  final String title;

  ProductModel({
    required this.categoryId,
    required this.colors,
    required this.createdDate,
    required this.discountedPrice,
    required this.gender,
    required this.images,
    required this.price,
    required this.sizes,
    required this.productId,
    required this.salesNumber,
    required this.title,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      categoryId: map['categoryId'] ?? '',
      colors: (map['colors'] as List)
          .map((e) => ProductColorModel.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
      createdDate: map['createdDate'] ?? Timestamp.now(),
      discountedPrice: (map['discountedPrice'] as num).toDouble(),
      gender: map['gender'] ?? 0,
      images: List<String>.from(map['images'] ?? []),
      price: (map['price'] as num).toDouble(),
      sizes: List<String>.from(map['sizes'] ?? []),
      productId: map['productId'] ?? '',
      salesNumber: map['salesNumber'] ?? 0,
      title: map['title'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoryId': categoryId,
      'colors': colors.map((e) => e.toMap()).toList(),
      'createdDate': createdDate,
      'discountedPrice': discountedPrice,
      'gender': gender,
      'images': images,
      'price': price,
      'sizes': sizes,
      'productId': productId,
      'salesNumber': salesNumber,
      'title': title,
    };
  }

  ProductEntity toEntity() {
    return ProductEntity(
      categoryId: categoryId,
      colors: colors.map((e) => e.toEntity()).toList(),
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      gender: gender,
      images: images,
      price: price,
      sizes: sizes,
      productId: productId,
      salesNumber: salesNumber,
      title: title,
    );
  }

  factory ProductModel.fromEntity(ProductEntity entity) {
    return ProductModel(
      categoryId: entity.categoryId,
      colors: entity.colors.map((e) => e.toModel()).toList(),
      createdDate: entity.createdDate,
      discountedPrice: entity.discountedPrice,
      gender: entity.gender,
      images: entity.images,
      price: entity.price,
      sizes: entity.sizes,
      productId: entity.productId,
      salesNumber: entity.salesNumber,
      title: entity.title,
    );
  }
}

extension ProductXEntity on ProductEntity {
  ProductModel toModel() {
    return ProductModel(
      categoryId: categoryId,
      colors: colors.map((e) => e.toModel()).toList(),
      createdDate: createdDate,
      discountedPrice: discountedPrice,
      gender: gender,
      images: images,
      price: price,
      sizes: sizes,
      productId: productId,
      salesNumber: salesNumber,
      title: title,
    );
  }
}
