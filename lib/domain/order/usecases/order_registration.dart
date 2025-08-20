import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/data/order/models/order_registration_req.dart';
import 'package:locally/domain/order/repository/order.dart';
import 'package:locally/service_locator.dart';

class OrderRegistrationUseCase implements UseCase<Either,OrderRegistrationReq> {
  @override
  Future<Either> call({OrderRegistrationReq ? params}) async {
    return sl<OrderRepository>().orderRegistration(params!);
  }

}