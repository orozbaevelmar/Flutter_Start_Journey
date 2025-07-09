import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure({this.message = ''});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({super.message = 'Server error'});
}

class CacheFailure extends Failure {
  const CacheFailure({super.message = 'Cache error'});
}

class NetworkFailure extends Failure {
  const NetworkFailure({super.message = 'Network error'});
}

class ValidationFailure extends Failure {
  const ValidationFailure({super.message = 'Validation error'});
}
