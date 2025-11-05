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

class OfflineFailure extends Failure {
  const OfflineFailure({super.message = 'Offline error'});
}

class WeekPassFailure extends Failure {
  const WeekPassFailure({super.message = 'Week Pass error'});
}

class ExistedAccountFailure extends Failure {
  const ExistedAccountFailure({super.message = 'Existed account error'});
}

class NoUserFailure extends Failure {
  const NoUserFailure({super.message = 'No user error'});
}

class WrongPasswordFailure extends Failure {
  const WrongPasswordFailure({super.message = 'Wrong password error'});
}

class UnmatchedPassFailure extends Failure {
  const UnmatchedPassFailure({super.message = 'Unmatched pass error'});
}

class NotLoggedInFailure extends Failure {
  const NotLoggedInFailure({super.message = 'Not logged in error'});
}

class EmailVerifiedFailure extends Failure {
  const EmailVerifiedFailure({super.message = 'Email Verified error'});
}

class TooManyRequestsFailure extends Failure {
  const TooManyRequestsFailure({super.message = 'Too many requests error'});
}
