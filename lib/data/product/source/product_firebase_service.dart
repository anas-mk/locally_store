import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:locally/core/error/failure.dart';
import 'package:locally/data/product/models/product.dart';
import 'package:locally/domain/product/entities/product.dart';

abstract class ProductFirebaseService {
  Future<Either<Failure, List<ProductModel>>> getTopSelling();
  Future<Either<Failure, List<ProductModel>>> getNewIn();
  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryId(String categoryId);
  Future<Either<Failure, List<ProductModel>>> getProductsByTitle(String title);
  Future<Either<Failure, bool>> addOrRemoveFavoriteProduct(ProductEntity product);
  Future<bool> isFavorite(String productId);
  Future<Either<Failure, List<ProductModel>>> getFavoritesProducts();
}

class ProductFirebaseServiceImpl extends ProductFirebaseService {
  final _firestore = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  @override
  Future<Either<Failure, List<ProductModel>>> getTopSelling() async {
    try {
      var returnedData = await _firestore
          .collection('Products')
          .where('salesNumber', isGreaterThanOrEqualTo: 20)
          .get();

      final products = returnedData.docs
          .map((doc) => ProductModel.fromMap(doc.data()..addAll({"productId": doc.id})))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getNewIn() async {
    try {
      var returnedData = await _firestore
          .collection('Products')
          .where('createdDate', isGreaterThanOrEqualTo: DateTime(2024, 7, 25))
          .get();

      final products = returnedData.docs
          .map((doc) => ProductModel.fromMap(doc.data()..addAll({"productId": doc.id})))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByCategoryId(String categoryId) async {
    try {
      var returnedData = await _firestore
          .collection('Products')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      final products = returnedData.docs
          .map((doc) => ProductModel.fromMap(doc.data()..addAll({"productId": doc.id})))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getProductsByTitle(String title) async {
    try {
      var returnedData = await _firestore
          .collection('Products')
          .where('title', isGreaterThanOrEqualTo: title)
          .get();

      final products = returnedData.docs
          .map((doc) => ProductModel.fromMap(doc.data()..addAll({"productId": doc.id})))
          .toList();

      return Right(products);
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }

  @override
  Future<Either<Failure, bool>> addOrRemoveFavoriteProduct(ProductEntity product) async {
    try {
      var user = _auth.currentUser;
      if (user == null) return Left(ServerFailure('User not logged in'));

      var favoritesRef = _firestore
          .collection("Users")
          .doc(user.uid)
          .collection('Favorites');

      var existing = await favoritesRef
          .where('productId', isEqualTo: product.productId)
          .get();

      if (existing.docs.isNotEmpty) {
        await existing.docs.first.reference.delete();
        return const Right(false); // removed
      } else {
        await favoritesRef.add(ProductModel.fromEntity(product).toMap());
        return const Right(true); // added
      }
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }

  @override
  Future<bool> isFavorite(String productId) async {
    try {
      var user = _auth.currentUser;
      if (user == null) return false;

      var products = await _firestore
          .collection("Users")
          .doc(user.uid)
          .collection('Favorites')
          .where('productId', isEqualTo: productId)
          .get();

      return products.docs.isNotEmpty;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> getFavoritesProducts() async {
    try {
      var user = _auth.currentUser;
      if (user == null) return Left(ServerFailure('User not logged in'));

      var returnedData = await _firestore
          .collection("Users")
          .doc(user.uid)
          .collection('Favorites')
          .get();

      final favorites = returnedData.docs
          .map((doc) => ProductModel.fromMap(doc.data()..addAll({"productId": doc.id})))
          .toList();

      return Right(favorites);
    } catch (e) {
      return Left(ServerFailure('Please try again'));
    }
  }
}
