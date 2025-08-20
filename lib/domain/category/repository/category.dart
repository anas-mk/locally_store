import 'package:dartz/dartz.dart';
import 'package:locally/domain/category/entity/category.dart';

abstract class CategoryRepository {
  Future<Either<String, List<CategoryEntity>>> getCategories();
}
