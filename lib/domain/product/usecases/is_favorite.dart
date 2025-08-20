import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/product/repository/product.dart';
import 'package:locally/service_locator.dart';

class IsFavoriteUseCase implements UseCase<bool,String> {

  @override
  Future<bool> call({String ? params}) async {
    return await sl<ProductRepository>().isFavorite(params!);
  }

}