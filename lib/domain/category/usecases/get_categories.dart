import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/category/entity/category.dart';
import 'package:locally/domain/category/repository/category.dart';

// class GetCategoriesUseCase implements UseCase<Either,dynamic> {
//
//   @override
//   Future<Either> call({dynamic params}) async {
//     return await sl<CategoryRepository>().getCategories();
//   }
//
// }

class GetCategoriesUseCase implements UseCase<Either<String, List<CategoryEntity>>, void> {
  final CategoryRepository repository;

  GetCategoriesUseCase(this.repository);

  @override
  Future<Either<String, List<CategoryEntity>>> call({void params}) {
    return repository.getCategories();
  }
}
