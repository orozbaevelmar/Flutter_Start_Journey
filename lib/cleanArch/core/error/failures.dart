abstract class Failure {
  final String message;
  final int? code;

  const Failure({required this.message, this.code});
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, super.code});
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message, super.code});
}

class NetworkFailure extends Failure {
  const NetworkFailure({required super.message, super.code});
}

class UnknownFailure extends Failure {
  const UnknownFailure({required super.message, super.code});
}

/// Additional specific failures

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
