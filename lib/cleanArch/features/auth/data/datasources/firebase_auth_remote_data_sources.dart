import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:start_journey/cleanArch/core/error/exceptions.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_up_use_case.dart';

const _tag = " [ AuthRemoteDataSource ]";

abstract class AuthRemoteDataSource {
  Future<UserCredential> singInWithEmailPassword(SignInParams params);
  Future<UserCredential> singUpWithEmailPassword(SignUpParams params);
}

@LazySingleton(as: AuthRemoteDataSource)
class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  final FirebaseAuth _firebaseAuth;

  @override
  Future<UserCredential> singInWithEmailPassword(SignInParams params) async {
    log("$_tag, sign in params: ${params.toJson()}");

    try {
      await _firebaseAuth.currentUser?.reload();

      final res = await _firebaseAuth.signInWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      log("$_tag, sign in response: $res");
      return res;
    } on FirebaseAuthException catch (e) {
      log("$_tag, <signIn()> FirebaseAuthException: ${e.code}");
      if (e.code == 'user-not-found') {
        throw ExistedAccountException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordException();
      } else {
        throw ServerException(e.toString());
      }
    } catch (e) {
      throw ServerException('An unknown error occurred: ${e.toString()}');
    }
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
  Future<UserCredential> singUpWithEmailPassword(SignUpParams params) async {
    log("$_tag, sign up params: ${params.toJson()}");
    try {
      await _firebaseAuth.currentUser?.reload();

      final UserCredential userCredential =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: params.email,
        password: params.password,
      );
      User? user = userCredential.user;
      if (user != null) {
        await user.updateDisplayName(params.name);
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      log("$_tag, <signUp()> FirebaseAuthException: ${e.code}");
      if (e.code == 'weak-password') {
        throw WeekPassException();
      } else if (e.code == 'email-already-in-use') {
        throw ExistedAccountException();
      } else {
        throw ServerException();
      }
    } catch (e) {
      throw ServerException('An unknown error occurred: ${e.toString()}');
    }
  }
}
