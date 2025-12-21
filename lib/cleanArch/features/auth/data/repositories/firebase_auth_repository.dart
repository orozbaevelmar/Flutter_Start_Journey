import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_journey/cleanArch/core/error/exceptions.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';
import 'package:start_journey/cleanArch/core/network/netowrk_info/network_info.dart';
import 'package:start_journey/cleanArch/features/auth/data/datasources/firebase_auth_remote_data_sources.dart';
import 'package:start_journey/cleanArch/features/auth/data/models/is_logged_in_model.dart';
import 'package:start_journey/cleanArch/features/auth/domain/repositories/auth_repository.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_in_use_case.dart';
import 'package:start_journey/cleanArch/features/auth/domain/usecases/sign_up_use_case.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserCredential>> singInWithEmailPassword(
      SignInParams params) async {
    if (await networkInfo.isConnected) {
      try {
        final userCredential =
            await authRemoteDataSource.singInWithEmailPassword(params);
        return Right(userCredential);
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message ?? 'ServerFailure'));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> singUpWithEmailPassword(
    SignUpParams params,
  ) async {
    if ((await networkInfo.isConnected) == false) {
      return Left(OfflineFailure());
    }

    try {
      final userCredential =
          await authRemoteDataSource.singUpWithEmailPassword(params);
      return Right(userCredential);
    } on WeekPassException {
      return Left(WeekPassFailure());
    } on ExistedAccountException {
      return Left(ExistedAccountFailure());
    } on ServerException {
      return Left(ServerFailure(message: 'ServerFailure'));
    }
  }

  @override
  IsLoggedInModel isLoggedIn() {
    try {
      final userCredential = FirebaseAuth.instance.currentUser;

      if (userCredential != null && userCredential.emailVerified) {
        return IsLoggedInModel(isVerifyingEmail: false, isLoggedIn: true);
      } else if (userCredential != null) {
        return const IsLoggedInModel(isVerifyingEmail: true, isLoggedIn: false);
      } else {
        return const IsLoggedInModel(
          isVerifyingEmail: false,
          isLoggedIn: false,
        );
      }
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        await FirebaseAuth.instance.signOut();
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure(message: e.toString()));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
