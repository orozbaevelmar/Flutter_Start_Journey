import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart' as injectable;

import 'package:start_journey/cleanArch/core/di/injection.config.dart';

import 'package:start_journey/cleanArch/core/loggers/log.dart';
import 'package:start_journey/cleanArch/core/loggers/log_message.dart';

final getIt = GetIt.instance;

@injectable.InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies(String env) async {
  Log.i(
    LogMessage(appVersion: Log.appVersion, eventName: LogMessage.getItInit),
  );
  await $initGetIt(getIt, environment: env);
}
