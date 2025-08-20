import 'package:dartz/dartz.dart';
import 'package:locally/data/category/models/category.dart';
import 'package:locally/domain/category/entity/category.dart';
import 'package:locally/domain/category/repository/category.dart';
import 'package:locally/domain/category/source/category_firebase_service.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryFirebaseService categoryFirebaseService;

  CategoryRepositoryImpl(this.categoryFirebaseService);

  @override
  Future<Either<String, List<CategoryEntity>>> getCategories() async {
    var categories = await categoryFirebaseService.getCategories();
    return categories.fold(
          (error) => Left(error),
          (data) => Right(
          List.from(data).map((e) => CategoryModel.fromMap(e).toEntity()).toList()
      ),
    );
  }
}
