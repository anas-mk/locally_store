import 'package:dartz/dartz.dart';
import 'package:locally/data/auth/models/user_creation_req.dart';
import 'package:locally/data/auth/models/user_signin_req.dart';

abstract class AuthRepository {

  Future<Either> signup(UserCreationReq user);
  Future<Either> signin(UserSigninReq user);
  Future<Either> getAges();
  Future<Either> sendPasswordRestEmail(String email);
  Future<bool> isLoggedIn();
  Future<Either> getUser();


}