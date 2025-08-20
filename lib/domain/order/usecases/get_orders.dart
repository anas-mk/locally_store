import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/order/repository/order.dart';
import 'package:locally/service_locator.dart';


class GetOrdersUseCase implements UseCase<Either,dynamic> {

  @override
  Future<Either> call({dynamic params}) async {
    return sl<OrderRepository>().getOrders();
  }

}