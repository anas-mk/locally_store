import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/product/entities/product.dart';
import 'package:locally/domain/product/repository/product.dart';
import 'package:locally/service_locator.dart';

class AddOrRemoveFavoriteProductUseCase implements UseCase<Either,ProductEntity> {

  @override
  Future<Either> call({ProductEntity? params}) async {
    return await sl<ProductRepository>().addOrRemoveFavoriteProduct(params!);
  }

}