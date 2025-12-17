// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/core/usecases/usecase.dart';
import 'package:start_journey/moveToCleanArch/features/auth/domain/repositories/auth_repository.dart';

class SignUpUseCase implements UseCase<UserCredential, SignUpParams> {
  final AuthRepository authRepository;

  const SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserCredential>> call(SignUpParams params) async {
    return await authRepository.singUpWithEmailPassword(params);
  }
}

class SignUpParams {
  final String name;
  final String email;
  final String password;

  SignUpParams({
    required this.name,
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'name': name,
      'email': email,
      'password': password,
    };
  }
}
