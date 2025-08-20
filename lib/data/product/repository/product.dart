import 'package:dartz/dartz.dart';
import 'package:locally/core/error/failure.dart';
import 'package:locally/data/product/source/product_firebase_service.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/domain/product/repository/product.dart';

class ProductRepositoryImpl extends ProductRepository {
  final ProductFirebaseService firebaseService;

  ProductRepositoryImpl(this.firebaseService);

  @override
  Future<Either<Failure, List<ProductEntity>>> getTopSelling() async {
    final result = await firebaseService.getTopSelling();
    return result.fold(
          (error) => Left(error),
          (data) => Right(
        data.map((model) => model.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getNewIn() async {
    final result = await firebaseService.getNewIn();
    return result.fold(
          (error) => Left(error),
          (data) => Right(
        data.map((model) => model.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByCategoryId(String categoryId) async {
    final result = await firebaseService.getProductsByCategoryId(categoryId);
    return result.fold(
          (error) => Left(error),
          (data) => Right(
        data.map((model) => model.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProductsByTitle(String title) async {
    final result = await firebaseService.getProductsByTitle(title);
    return result.fold(
          (error) => Left(error),
          (data) => Right(
        data.map((model) => model.toEntity()).toList(),
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> addOrRemoveFavoriteProduct(ProductEntity product) async {
    final result = await firebaseService.addOrRemoveFavoriteProduct(product);
    return result.fold(
          (error) => Left(error),
          (data) => Right(data),
    );
  }

  @override
  Future<bool> isFavorite(String productId) async {
    return await firebaseService.isFavorite(productId);
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavoritesProducts() async {
    final result = await firebaseService.getFavoritesProducts();
    return result.fold(
          (error) => Left(error),
          (data) => Right(
        data.map((model) => model.toEntity()).toList(),
      ),
    );
  }
}
