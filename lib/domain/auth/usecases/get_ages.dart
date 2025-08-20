import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/domain/auth/repository/auth.dart';
import 'package:locally/service_locator.dart';

class GetAgesUseCase implements UseCase<Either,dynamic> {


  @override
  Future<Either> call({dynamic params}) async {
    return await sl<AuthRepository>().getAges();
  }

}