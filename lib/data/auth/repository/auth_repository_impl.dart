import 'package:dartz/dartz.dart';
import 'package:locally/data/auth/models/user.dart';
import 'package:locally/data/auth/models/user_creation_req.dart';
import 'package:locally/data/auth/models/user_signin_req.dart';
import 'package:locally/data/auth/source/auth_firebase_service.dart';
import 'package:locally/domain/auth/repository/auth.dart';
import 'package:locally/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signup(UserCreationReq user) async {
    return await sl<AuthFirebaseService>().signup(user);
  }

  @override
  Future<Either> signin(UserSigninReq user) async {
    return await sl<AuthFirebaseService>().signin(user);
  }

  @override
  Future<Either> getAges() async {
    return await sl<AuthFirebaseService>().getAges();
  }

  @override
  Future<Either> sendPasswordRestEmail(String email) async {
    return await sl<AuthFirebaseService>().sendPasswordRestEmail(email);
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthFirebaseService>().isLoggedIn();
  }

  @override
  Future<Either> getUser() async {
    var result = await sl<AuthFirebaseService>().getUser();

    return result.fold(
          (error) => Left(error),
          (data) {
        if (data == null) {
          return Left("User data is null or not found");
        }
        return Right(UserModel.fromMap(data).toEntity());
      },
    );
  }
}
