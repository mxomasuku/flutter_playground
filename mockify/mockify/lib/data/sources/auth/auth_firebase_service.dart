import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';

abstract class AuthFirebaseService {
  Future<void> signin();
  Future<Either> signup(CreateUserReq createUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<void> signin() async {
    try {} on FirebaseAuthException catch (e) {}
  }

  @override
  Future<Either> signup(createUserReq) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      return Right('Sign Up Was Successful');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == "weak-password") {
        message = "Password Selected Is Too Weak";
      } else if (e.code == "email-already-in-use") {
        message = "An account already exists with this email";
      }

      return Left(message);
    }
  }
}
