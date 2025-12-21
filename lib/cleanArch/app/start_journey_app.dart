import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:start_journey/core_bloc_provider.dart';
import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/core/loggers/log.dart';
import 'package:start_journey/cleanArch/core/loggers/log_message.dart';
import 'package:start_journey/cleanArch/core/theme/app_theme.dart';
import 'package:start_journey/cleanArch/core/utils/snackbar_service.dart';
import 'package:start_journey/cleanArch/features/splash/screen/splash_screen.dart';

class StartJourneyApp extends StatelessWidget {
  final AppFlavorConfig config;
  final FirebaseAnalytics analytics;

  const StartJourneyApp({
    super.key,
    required this.config,
    required this.analytics,
  });

  @override
  Widget build(BuildContext context) {
    final snackBarService = getIt<SnackBarService>();

    Log.i(
      LogMessage(
        appVersion: Log.appVersion,
        eventName: LogMessage.mainAppStart,
      ),
    );
    return CoreBlocProvider(
      child: ChangeNotifierProvider(
        create: (BuildContext context) => StartJourneyTheme(),
        child: Consumer<StartJourneyTheme>(
          builder: (_, startJourneyTheme, __) {
            return MaterialApp(
              title: config.appName,
              theme: startJourneyTheme.appTheme,
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: snackBarService.messengerKey,
              color: Colors.grey.shade100,
              home: SplashScreen(),
            );
          },
        ),
      ),
    );
  }
}
