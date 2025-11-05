import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_journey/moveToCleanArch/core/error/exceptions.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/models/login_model.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/models/register_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserCredential> register(RegisterModel registerModel);
  Future<UserCredential> login(LoginModel loginModel);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential> login(LoginModel loginModel) async {
    try {
      await _firebaseAuth.currentUser?.reload();
      return await _firebaseAuth.signInWithEmailAndPassword(
        email: loginModel.email,
        password: loginModel.password,
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw ExistedAccountException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw ServerException(message: e.toString());
      }
    }

    // on FirebaseException catch (e) {
    //   // Handle PlatformException
    //   if (e.code == 'ERROR_INVALID_CREDENTIAL') {
    //     return 'The supplied auth credential is incorrect, malformed, or expired.';
    //   }
    //   if (e.code == 'invalid-credential') {
    //     return 'The supplied auth credential is incorrect, malformed, or expired.';
    //   } else {
    //     return 'An unknown error occurred: ${e.message}';
    //   }
    // } catch (e) {
    //   // Catch any other types of exceptions and return a general error message
    //   return 'An unknown error occurred: ${e.toString()}';
    // }
  }

  String _firebaseAuthException(FirebaseAuthException e) {
    // Handle Firebase authentication-related errors
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email address is already in use. Please try logging in or use a different email.';
      case 'invalid-email':
        return 'The email address is invalid. Please check and enter a valid email.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support.';
      case 'weak-password':
        return 'The password provided is too weak. Please use a stronger password.';
      case 'too-many-requests':
        return 'Too many requests at the moment. Please try again later.';
      case 'user-token-expired':
        return 'Your session has expired. Please log in again.';
      case 'network-request-failed':
        return 'Network error occurred. Please check your internet connection.';
      case 'invalid-credential':
        return 'The supplied auth credential is incorrect, malformed or has expired.';
      default:
        return 'An unknown error occurred: ${e.message}';
    }
  }

  @override
  Future<UserCredential> register(RegisterModel registerModel) async {
    try {
      await _firebaseAuth.currentUser?.reload();

      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: registerModel.email,
        password: registerModel.password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(registerModel.firstName);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeekPassException();
      } else if (e.code == 'email-already-in-use') {
        throw ExistedAccountException();
      } else {
        throw ServerException();
      }
    }
  }
}
