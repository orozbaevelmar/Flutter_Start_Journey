// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';

class Failure {
  final String errorMessage;
  Failure(
    this.errorMessage,
  );
}

/* class ServerFailure extends Failure {
  ServerFailure({required String errorMessage})
      : super(errorMessage: errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
}

class CacheFailure extends Failure {
  CacheFailure({required String errorMessage})
      : super(errorMessage: errorMessage);

  @override
  // TODO: implement props
  List<Object?> get props => [errorMessage];
} */
