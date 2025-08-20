import 'package:locally/domain/product/entities/color.dart';

class ProductColorModel {
  final String title;
  final String hexCode;

  ProductColorModel({
    required this.title,
    required this.hexCode,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'hexCode': hexCode,
    };
  }

  factory ProductColorModel.fromMap(Map<String, dynamic> map) {
    return ProductColorModel(
      title: map['title'] ?? '',
      hexCode: map['hexCode'] ?? '',
    );
  }
}

extension ProductColorXModel on ProductColorModel {
  ProductColorEntity toEntity() {
    return ProductColorEntity(
      title: title,
      hexCode: hexCode,
    );
  }
}

extension ProductColorXEntity on ProductColorEntity {
  ProductColorModel toModel() {
    return ProductColorModel(
      title: title,
      hexCode: hexCode,
    );
  }
}

