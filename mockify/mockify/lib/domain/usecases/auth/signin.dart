import 'package:dartz/dartz.dart';
import 'package:mockify/core/usecase/usecase.dart';
import 'package:mockify/data/models/auth/sign_in_req.dart';
import 'package:mockify/domain/repository/auth/auth.dart';
import 'package:mockify/service_locator.dart';

class SignInUseCase implements Usecase<Either, SignInUserReq> {
  @override
  Future<Either> call({SignInUserReq? params}) async {
    return serviceLocator<AuthRepository>().signin(params!);
  }
}
