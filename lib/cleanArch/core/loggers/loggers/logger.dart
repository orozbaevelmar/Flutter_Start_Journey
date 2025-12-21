import 'package:start_journey/cleanArch/core/loggers/log_message.dart';

abstract class Logger {
  /// Verbose can cover a lot of ground,
  /// from the recording of critical errors to logging
  /// normal purchase transactions for an e-commerce app
  /// sto documenting every method that the software executes.
  void v(LogMessage message);

  /// use to provide a debug messages
  void d(LogMessage message, {bool verbose});

  /// Use it to log events
  void i(LogMessage message);

  /// use it to log warning, e.g. bad password
  void w(LogMessage message);

  /// Use it to log error
  void e(LogMessage message, Object error, {StackTrace? stackTrace});

  void setUserId(String? userId, [String? email]);
}

enum ConfigType { release, debug }
