import 'dart:core';
import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:start_journey/cleanArch/core/loggers/log_message.dart';
import 'package:start_journey/cleanArch/core/loggers/loggers/logger.dart';

class Log {
  static final _loggers = <Logger>[];

  static late String appVersion;

  static void addLogger(List<Logger> logger) => _loggers.addAll(logger);

  static bool removeLogger(Logger logger) => _loggers.remove(logger);

  static T? getLogger<T extends Logger>() =>
      _loggers.firstWhereOrNull((element) => element is T) as T?;

  static void setUserIdentity(String? userId, [String? email]) {
    for (final logger in _loggers) {
      logger.setUserId(userId);
    }
  }

  /// Verbose can cover a lot of ground,
  /// from the recording of critical errors to logging
  /// normal purchase transactions for an e-commerce app
  /// to documenting every method that the software executes.
  ///
  /// Log.v('[$_tag] - some message');
  ///
  static void v(LogMessage message) {
    for (final logger in _loggers) {
      logger.v(message);
    }
  }

  /// use to provide debug messages
  static void d(LogMessage message, {bool verbose = false}) {
    for (final logger in _loggers) {
      logger.d(message, verbose: verbose);
    }
  }

  /// Use it to log events
  static void i(LogMessage message) {
    for (final logger in _loggers) {
      logger.i(message);
    }
  }

  /// use it to log warning, e.g. bad password
  static void w(LogMessage message) {
    for (final logger in _loggers) {
      logger.w(message);
    }
  }

  /// Use it to log error
  static void e(dynamic error, {String? message, StackTrace? stackTrace}) {
    final text = [
      message,
      error,
      stackTrace,
    ].where((element) => element != null).map((e) => e.toString()).join('\n');
    if (kDebugMode) {
      print(text);
    }

    for (final logger in _loggers) {
      logger.e(
        LogMessage(
          message: text,
          appVersion: appVersion,
          eventName: LogMessage.exceptionTagName,
        ),
        error,
        stackTrace: stackTrace,
      );
    }
  }

  static void flutterError(FlutterErrorDetails details) {
    Log.e(details.exception, stackTrace: details.stack);
    FlutterError.presentError(details);
  }
}
