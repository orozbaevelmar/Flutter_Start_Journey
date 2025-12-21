class ApiConstants {
  static const String unAuthenticatedConsumer = 'unAuthenticatedConsumer';
  static const String authenticatedConsumer = 'authenticatedConsumer';

  static const String kSocketUrlName = 'socketUrl';

  ///Websocket
  static const String kSocketBaseUrl = 'wss://app.dev.startJourney.com';

  /// Auth
  static const String loginEndPoint = 'auth/signUp';
  static const String registerEndPoint = 'auth/register';
  static const String refreshTokenEndPoint = 'auth/refresh-token';
  static const String logoutEndPoint = 'auth/logout';

  static String get baseUrl {
    return const String.fromEnvironment(
      'API_BASE_URL',
      defaultValue: 'https://api.dev.startJourney.com/',
    );
  }

  /// Settings
  static const String emailPreferences = 'sso/email-preferences';
}

class ApiStatusCodes {
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int serverError = 500;
}
