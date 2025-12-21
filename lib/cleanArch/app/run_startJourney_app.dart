import 'dart:async';
import 'dart:developer';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:package_info_plus/package_info_plus.dart';

import 'package:start_journey/cleanArch/app/app_config.dart';
import 'package:start_journey/cleanArch/app/start_journey_app.dart';
import 'package:start_journey/cleanArch/core/di/injection.dart';
import 'package:start_journey/cleanArch/core/loggers/log.dart';
import 'package:start_journey/cleanArch/core/loggers/loggers/console_logger.dart';

import 'package:start_journey/firebase_options.dart' as dev;
import 'package:start_journey/cleanArch/core/loggers/loggers/firebase_logger.dart';

Future<void> runStartJourneyApp(String env) async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle.dark,
    );
    final firebaseOptions = switch (env) {
      // 'prod' => prod.DefaultFirebaseOptions.currentPlatform
      'dev' => dev.DefaultFirebaseOptions.currentPlatform,
      _ => throw UnsupportedError('Invalid flavor: $env'),
    };
    await Firebase.initializeApp(options: firebaseOptions);

    await registerAppVersion();

    log("firebase init");
    // Initialize dependencies
    await configureDependencies(env);
    log("injection init");

    final FirebaseAnalytics firebaseAnalytics = FirebaseAnalytics.instance;

    log("fb analytics init");

    final appConfig = getIt<AppFlavorConfig>();

    log("config init");

    await _initializeEnvironmentFeatures(appConfig, firebaseAnalytics);

    log("env init");

    // NavigationHelper(config: appConfig, firebaseAnalytics: firebaseAnalytics);

    log("router init");

    // Run the app
    runApp(StartJourneyApp(config: appConfig, analytics: firebaseAnalytics));
  }, (error, stackTrace) => _handleError(error, stackTrace));
}

Future<void> _handleError(Object error, StackTrace stackTrace) async {
  await registerAppVersion();
  Log.e(error, message: "Error in runZonedGuarded", stackTrace: stackTrace);
}

Future<void> registerAppVersion() async {
  final appVersionData = await PackageInfo.fromPlatform();
  final appVersion = 'v${appVersionData.version}'
      '+${appVersionData.buildNumber}';
  Log.appVersion = appVersion;
}

Future<void> _initializeEnvironmentFeatures(
  AppFlavorConfig config,
  FirebaseAnalytics firebaseAnalytics,
) async {
  // Initialize logging if enabled
  if (config.enableLogging) {
    await registerAppVersion();
    Log.addLogger([FirebaseLogger(firebaseAnalytics: firebaseAnalytics)]);

    firebaseAnalytics.setAnalyticsCollectionEnabled(false);
  }

  // Initialize analytics if enabled
  if (config.enableAnalytics) {
    firebaseAnalytics.setAnalyticsCollectionEnabled(true);
    FirebaseAnalyticsObserver(analytics: firebaseAnalytics);
    Log.addLogger([FirebaseLogger(firebaseAnalytics: firebaseAnalytics)]);
  }

  // Initialize crashlytics if enabled
  if (config.enableCrashlytics) {
    FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

    /// enable recording of Non-fatale exception for Crashlytics:
    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;
  }

  // Set up environment-specific UI configurations
  if (config.isDevelopment) {
    Log.addLogger([ConsoleLogger()]);
  }
}
