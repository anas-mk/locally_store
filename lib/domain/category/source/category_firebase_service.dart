import 'package:dartz/dartz.dart';

abstract class CategoryFirebaseService {
  Future<Either<String, List<Map<String, dynamic>>>> getCategories();
}