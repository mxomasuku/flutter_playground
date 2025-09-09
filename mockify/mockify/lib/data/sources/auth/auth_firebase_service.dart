import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mockify/data/models/auth/create_user_req.dart';
import 'package:mockify/data/models/auth/sign_in_req.dart';

abstract class AuthFirebaseService {
  Future<Either> signin(SignInUserReq signInUserReq);
  Future<Either> signup(CreateUserReq createUserReq);
}

class AuthFirebaseServiceImpl extends AuthFirebaseService {
  @override
  Future<Either<String, String>> signin(SignInUserReq signInUserReq) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signInUserReq.email,
        password: signInUserReq.password,
      );
      return Right('Sign In Was Successful');
    } on FirebaseAuthException catch (e) {
      String message;

      switch (e.code) {
        case 'invalid-email':
          message = 'Email format is invalid';
          break;
        case 'user-disabled':
          message = 'This user has been disabled';
          break;
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Incorrect password';
          break;
        case 'too-many-requests':
          message = 'Too many attempts. Try again later';
          break;
        case 'operation-not-allowed':
          message = 'Email/password sign-in is not enabled';
          break;
        default:
          message = 'An unknown error occurred';
      }

      return Left(message);
    } catch (e) {
      return Left('Something went wrong: ${e.toString()}');
    }
  }

  @override
  Future<Either> signup(createUserReq) async {
    try {
      var data = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: createUserReq.email,
        password: createUserReq.password,
      );

      FirebaseFirestore.instance.collection('Users').add({
        'name': data.user?.displayName,
        'email': data.user?.email,
      });
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
