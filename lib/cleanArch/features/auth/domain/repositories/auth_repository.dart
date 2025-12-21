import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_up_use_case.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, UserCredential>> singInWithEmailPassword(
      SignInParams params);
  Future<Either<Failure, UserCredential>> singUpWithEmailPassword(
      SignUpParams params);
}
