import 'package:injectable/injectable.dart';

enum AppFlavor { dev, prod }

abstract class AppFlavorConfig {
  AppFlavor get flavor;

  String get apiBaseUrl;

  String get authUrl;

  String get staffInviteUrl;

  String get appName;

  String get androidAppId;

  String get iosAppId;

  String get googleApiKey;

  bool get enableLogging;

  bool get enableAnalytics;

  bool get enableCrashlytics;

  bool get isDevelopment;

  bool get isProduction;
}

@Environment('dev')
@Injectable(as: AppFlavorConfig)
class FlavorConfigDev extends AppFlavorConfig {
  @override
  AppFlavor get flavor => AppFlavor.dev;

  @override
  String get androidAppId => "kg.start.journey.app.dev";

  @override
  String get apiBaseUrl => "https://api.dev.startJourney.com/api/v2/";

  @override
  String get googleApiKey => "Acndfsafdsfasdfa";

  @override
  String get authUrl => "https://auth.dev.startJourney.com";

  @override
  bool get enableAnalytics => false;

  @override
  bool get enableCrashlytics => false;

  @override
  bool get enableLogging => true;

  @override

  /// TODO: add ios app id(when account created)
  String get iosAppId => "1111111111";

  @override
  String get appName => "Start Journey Dev";

  @override
  bool get isDevelopment => true;

  @override
  bool get isProduction => false;

  @override
  String get staffInviteUrl => "https://auth.dev.startJourney.com/invite/";
}

@Environment('prod')
@Injectable(as: AppFlavorConfig)
class FlavorConfigProd extends AppFlavorConfig {
  @override
  AppFlavor get flavor => AppFlavor.dev;

  @override
  String get androidAppId => "kg.start.journey.app.prod";

  @override
  String get apiBaseUrl => "https://api.dev.startJourney.com/api/v2/";

  @override
  String get googleApiKey => "Acndfsafdsfasdfa";

  @override
  String get authUrl => "https://auth.dev.startJourney.com";

  @override
  bool get enableAnalytics => true;

  @override
  bool get enableCrashlytics => true;

  @override
  bool get enableLogging => false;

  @override

  /// TODO: add ios app id(when account created)
  String get iosAppId => "1111111111";

  @override
  String get appName => "Start Journey";

  @override
  bool get isDevelopment => false;

  @override
  bool get isProduction => true;

  @override
  String get staffInviteUrl => "https://auth.dev.startJourney.com/invite/";
}
