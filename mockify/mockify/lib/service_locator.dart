import 'package:get_it/get_it.dart';
import 'package:mockify/data/respository/auth/auth_repository_impl.dart';
import 'package:mockify/data/sources/auth/auth_firebase_service.dart';
import 'package:mockify/domain/repository/auth/auth.dart';
import 'package:mockify/domain/usecases/auth/signup.dart';

final serviceLocator = GetIt.instance;

Future<void> initializeDependencies() async {
  serviceLocator.registerSingleton<AuthFirebaseService>(
    AuthFirebaseServiceImpl(),
  );
  serviceLocator.registerSingleton<AuthRepository>(AuthRepositoryImpl());

  serviceLocator.registerSingleton<SignUpUseCase>(SignUpUseCase());
}
