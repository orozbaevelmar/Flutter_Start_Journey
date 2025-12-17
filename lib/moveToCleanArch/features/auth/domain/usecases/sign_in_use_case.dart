// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/core/usecases/usecase.dart';
import 'package:start_journey/moveToCleanArch/features/auth/domain/repositories/auth_repository.dart';

class SignInUseCase implements UseCase<UserCredential, SignInParams> {
  final AuthRepository authRepository;

  const SignInUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(SignInParams params) async {
    return await authRepository.singInWithEmailPassword(params);
  }
}

class SignInParams {
  final String email;
  final String password;

  SignInParams({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }
}
