import 'package:dartz/dartz.dart';
import 'package:start_journey/moveToCleanArch/core/error/failures.dart';

///
/// Type == SuccessType
///
///

abstract interface class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

class NoParams {}
