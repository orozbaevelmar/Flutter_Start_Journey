import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:start_journey/cleanArch/core/error/dio_error_handle_util.dart';
import 'package:start_journey/cleanArch/core/error/failures.dart';

Future<Either<Failure, T>> safeCall<T>(Future<T> Function() call) async {
  try {
    final result = await call();
    return Right(result);
  } on DioException catch (e) {
    final failure = handleDioError(e);
    return Left(failure);
  } catch (e) {
    return Left(UnknownFailure(message: e.toString()));
  }
}
