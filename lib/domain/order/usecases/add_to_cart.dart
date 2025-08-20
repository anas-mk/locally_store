import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/data/order/models/add_to_cart_req.dart';
import 'package:locally/domain/order/repository/order.dart';
import 'package:locally/service_locator.dart';


class AddToCartUseCase implements UseCase<Either,AddToCartReq> {
  @override
  Future<Either> call({AddToCartReq ? params}) async {
    return sl<OrderRepository>().addToCart(params!);
  }

}