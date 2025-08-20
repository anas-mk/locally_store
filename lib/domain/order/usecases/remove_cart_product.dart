import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/order/repository/order.dart';
import 'package:locally/service_locator.dart';


class RemoveCartProductUseCase implements UseCase<Either,String> {
  @override
  Future<Either> call({String ? params}) async {
    return sl<OrderRepository>().removeCartProduct(params!);
  }

}