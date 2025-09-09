import 'package:dartz/dartz.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';
import 'package:mockify/data/models/auth/sign_in_req.dart';
import 'package:mockify/data/sources/auth/auth_firebase_service.dart';
import 'package:mockify/domain/repository/auth/auth.dart';
import 'package:mockify/service_locator.dart';

class AuthRepositoryImpl extends AuthRepository {
  @override
  Future<Either> signin(SignInUserReq signInUserReq) async {
    return await serviceLocator<AuthFirebaseService>().signin(signInUserReq);
  }

  @override
  Future<Either> signup(CreateUserReq createUserReq) async {
    return await serviceLocator<AuthFirebaseService>().signup(createUserReq);
  }
}
