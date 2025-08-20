import 'package:dartz/dartz.dart';
import 'package:locally/core/usecase/usecase.dart';
import 'package:locally/data/auth/models/user_signin_req.dart';
import 'package:locally/domain/auth/repository/auth.dart';
import 'package:locally/service_locator.dart';


class SignInUseCase implements UseCase<Either,UserSigninReq> {


  @override
  Future<Either> call({UserSigninReq ? params}) async {
    return await sl<AuthRepository>().signin(params!);
  }

}