import 'dart:isolate';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:start_journey/cleanArch/core/loggers/extensions/isolate_runner.dart';
import 'package:start_journey/cleanArch/core/loggers/extensions/platform_extension.dart';
import 'package:start_journey/cleanArch/core/loggers/log_message.dart';
import 'package:start_journey/cleanArch/core/loggers/loggers/logger.dart';

class ConsoleLogger implements Logger {
  ConsoleLogger({this.shouldPrint = true}) {
    if (!PlatformExtensions.isWeb) {
      _isolate = IsolateRunner(_printSpawnEntry);
    }
  }
  late final IsolateRunner? _isolate;
  final bool shouldPrint;

  void close() {
    _isolate?.close();
  }

  @override
  void v(LogMessage message) {
    _print(message.toString());
  }

  @override
  void d(LogMessage message, {bool verbose = false}) {
    if (verbose) {
      _print(message.toString());
    } else {
      if (shouldPrint) {
        debugPrint(message.toString());
      }
    }
  }

  @override
  void i(LogMessage message) {
    _print(message.toString());
  }

  @override
  void w(LogMessage message) {
    _print(message.toString(), async: false);
  }

  @override
  void e(LogMessage message, Object error, {StackTrace? stackTrace}) {
    _print(message.toString(), async: false);
  }

  static void _printSpawnEntry(SendPort sendPort) {
    final port = ReceivePort();
    sendPort.send(port.sendPort);
    port.listen(
      (message) {
        if (message is String) {
          _printWrapped(message);
        } else if (message == null) {
          port.close();
        }
      },
    );
  }

  static void _printWrapped(String message) {
    const lineLength = 1000;
    final length = message.length;
    var index = 0;
    while (index < length) {
      // ignore: avoid_print
      print(message.substring(index, min(index + lineLength, length)));
      index += lineLength;
    }
  }

  void _print(String message, {bool async = true}) {
    if (shouldPrint) {
      if (async && !PlatformExtensions.isWeb) {
        _isolate?.send(message);
      } else {
        _printWrapped(message);
      }
    }
  }

  @override
  void setUserId(String? userId, [String? email]) {}
}
