import 'package:dartz/dartz.dart';
import 'package:mockify/core/usecase/usecase.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';
import 'package:mockify/domain/repository/auth/auth.dart';
import 'package:mockify/service_locator.dart';

class SignUpUseCase implements Usecase<Either, CreateUserReq> {
  @override
  Future<Either> call({CreateUserReq? params}) async {
    return serviceLocator<AuthRepository>().signup(params!);
  }
}
