
import 'package:dartz/dartz.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';
import 'package:mockify/data/models/auth/sign_in_req.dart';

abstract class AuthRepository {
  
  Future<Either>  signup(CreateUserReq createUserReq);

  Future<Either> signin(SignInUserReq signInUserReq);
}