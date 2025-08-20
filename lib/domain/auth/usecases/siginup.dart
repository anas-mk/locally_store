import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/data/auth/models/user_creation_req.dart';
import 'package:locally/domain/auth/repository/auth.dart';
import 'package:locally/service_locator.dart';


class SignupUseCase implements UseCase<Either,UserCreationReq> {


  @override
  Future<Either> call({UserCreationReq ? params}) async {
    return await sl<AuthRepository>().signup(params!);
  }
  
}