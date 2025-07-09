// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:dartz/dartz.dart';
import 'package:start_journey/moveToCleanArch/core/error/exceptions.dart';

import 'package:start_journey/moveToCleanArch/core/error/failures.dart';
import 'package:start_journey/moveToCleanArch/features/auth/data/datasources/auth_remote_data_source.dart';
import 'package:start_journey/moveToCleanArch/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImpl(
    this.authRemoteDataSource,
  );
  @override
  Future<Either<Failure, String>> loginWithEmailPassword(
      {required String email, required String password}) async {
    // TODO: implement loginWithEmailPassword
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, String>> signUpWithEmailPassword(
      {required String name,
      required String email,
      required String password}) async {
    try {
      final userId = await authRemoteDataSource.signUpWithEmailPassword(
        name: name,
        email: email,
        password: password,
      );

      return right(userId);
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
