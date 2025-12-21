import 'dart:async';
import 'dart:isolate';

import 'package:queue/queue.dart';

typedef IsolateEntry = void Function(SendPort);

class IsolateRunner {
  ///  [entry] must be a top-level function or a static method
  ///  that can be called with a single [SendPort] argument.
  ///
  ///     void _execute(SendPort sendPort) async {
  ///       final port = ReceivePort();
  ///       sendPort.send(port.sendPort);
  ///       await for (final data in port) {
  ///         // Perform action on the `data`
  ///       }
  ///     }
  IsolateRunner(IsolateEntry entry) {
    _init(entry);
  }
  final _queue = Queue();
  final _receivePort = ReceivePort();
  late final Isolate _isolate;
  SendPort? _sendPort;

  void close() {
    _sendPort!.send(null);
    _isolate.kill();
  }

  void send(Object? message) {
    if (_sendPort == null) {
      _queue.add(() async => _sendPort?.send(message));
    } else {
      _sendPort?.send(message);
    }
  }

  Future<void> _init(IsolateEntry entry) async {
    unawaited(_queue.add(
          () async => _isolate = await Isolate.spawn(entry, _receivePort.sendPort),
    ));
    _sendPort = await _queue.add(() async => await _receivePort.first);

    await _queue.onComplete;
    _queue.dispose();
    _receivePort.close();
  }
}
