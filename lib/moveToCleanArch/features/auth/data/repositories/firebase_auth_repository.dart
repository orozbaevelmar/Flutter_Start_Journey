import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:start_journey/moveToCleanArch/core/error/exceptions.dart';
import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/core/network/network_info.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/datasources/firebase_auth_remote_data_sources.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/models/is_logged_in_model.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/models/login_model.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/models/register_model.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserCredential>> login(LoginModel loginModel);
  Future<Either<Failure, UserCredential>> register(RegisterModel registerModel);
  IsLoggedInModel isLoggedIn();
  Future<Either<Failure, Unit>> logOut();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final NetworkInfo networkInfo;
  AuthRepositoryImpl({
    required this.networkInfo,
    required this.authRemoteDataSource,
  });

  @override
  Future<Either<Failure, UserCredential>> login(LoginModel loginModel) async {
    if (await networkInfo.isConnected) {
      try {
        final userCredential = await authRemoteDataSource.login(loginModel);
        return Right(userCredential);
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on WrongPasswordException {
        return Left(WrongPasswordFailure());
      } on ServerException catch (e) {
        return Left(ServerFailure(message: e.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> register(
    RegisterModel registerModel,
  ) async {
    if (!await networkInfo.isConnected) {
      return Left(OfflineFailure());
    }
    // else if (signUp.password != signUp.repeatedPassword) {
    //   return Left(UnmatchedPassFailure());
    // }
    else {
      try {
        final userCredential = await authRemoteDataSource.register(
          registerModel,
        );
        return Right(userCredential);
      } on WeekPassException {
        return Left(WeekPassFailure());
      } on ExistedAccountException {
        return Left(ExistedAccountFailure());
      } on ServerException {
        return Left(ServerFailure());
      }
    }
  }

  @override
  IsLoggedInModel isLoggedIn() {
    try {
      print('okoko');
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
      print('ERROR--12-$e');
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<Either<Failure, Unit>> logOut() async {
    if (await networkInfo.isConnected) {
      try {
        await FirebaseAuth.instance.signOut();
        return const Right(unit);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
