import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:start_journey/cleanArch/core/loggers/log_message.dart';
import 'package:start_journey/cleanArch/core/loggers/loggers/logger.dart';

class FirebaseLogger extends Logger {
  FirebaseLogger({required FirebaseAnalytics firebaseAnalytics})
      : _analytics = firebaseAnalytics {
    _init();
  }

  final FirebaseAnalytics _analytics;

  static String? appVersion;

  @override
  void d(LogMessage message, {bool verbose = false}) {}

  @override
  void e(LogMessage message, Object error, {StackTrace? stackTrace}) {}

  @override
  void i(LogMessage message) {
    _logUserSuperProperties(message);

    if (message.eventName == LogMessage.loginSuccessful) {
      _logSignIn();
    } else if (message.eventName == LogMessage.signupSuccessful) {
      _logCreateAccount(message.propertyValues?['companyName']);
    } else if (_screenOpen(message)) {
      _logScreenView(message);
    } else {
      _logEvent(message);
    }
  }

  @override
  void v(LogMessage message) {}

  @override
  void w(LogMessage message) {}

  @override
  void setUserId(String? userId, [String? email]) {
    _setUserId(userId);
    if (email != null) {
      _setUserEmail(email);
    }
  }

  Object? _toFaValueOrNull(dynamic v) {
    if (v == null) return null;
    if (v is num || v is String) return v;
    if (v is bool) return v ? 1 : 0;
    if (v is Enum) return v.name;
    if (v is DateTime) return v.toIso8601String();
    return v.toString();
  }

  Map<String, Object> _sanitizeParams(Map<String, Object?> raw) {
    final out = <String, Object>{};
    raw.forEach((key, value) {
      final converted = _toFaValueOrNull(value);
      if (converted != null) {
        if (converted is String || converted is num) {
          out[key] = converted;
        } else {
          out[key] = converted.toString();
        }
      }
    });
    return out;
  }

  bool _screenOpen(LogMessage message) => <String>{
        LogMessage.splashScreen,
        LogMessage.loginScreen,
        LogMessage.adminScreen,
        LogMessage.settingsScreen,
        LogMessage.jobsScreen,
        LogMessage.jobDetailScreen,
        LogMessage.warehousesScreen,
        LogMessage.warehouseDetailScreen,
        LogMessage.accountScreen,
        LogMessage.createAccountScreen,
        LogMessage.changePasswordScreen,
        LogMessage.notificationsScreen,
        LogMessage.searchScreen,
      }.contains(message.eventName);

  String? _toStringOrNull(dynamic v) => v?.toString();

  Future<void> _logEvent(LogMessage message) async {
    final rawParams = <String, Object?>{
      ...(message.propertyValues ?? const <String, Object?>{}),
      'appVersion': message.appVersion,
    };

    final params = _sanitizeParams(rawParams);

    await _analytics.logEvent(
      name: message.eventName,
      parameters: params,
    );
  }

  Future<void> _logCreateAccount(String? companyName) async {
    await _analytics.logSignUp(signUpMethod: 'email-password');
  }

  Future<void> _logSignIn() async {
    await _analytics.logLogin(loginMethod: 'email-password');
  }

  Future<void> _logScreenView(LogMessage message) async {
    await _analytics.logScreenView(screenName: message.eventName);
  }

  Future<void> _setUserId(String? userId) async {
    await _analytics.setUserId(id: userId);
  }

  Future<void> _setSessionTimeoutDuration() async {
    await _analytics.setSessionTimeoutDuration(
      const Duration(milliseconds: 1800000),
    );
  }

  Future<void> _setUserEmail(String? email) async =>
      _analytics.setUserProperty(name: 'email', value: _toStringOrNull(email));

  Future<void> _setUserFirstName(String? firstName) async => _analytics
      .setUserProperty(name: 'first_name', value: _toStringOrNull(firstName));

  Future<void> _setUserLastName(String? lastName) async => _analytics
      .setUserProperty(name: 'last_name', value: _toStringOrNull(lastName));

  Future<void> _setUserCompanyName(String? companyName) async =>
      _analytics.setUserProperty(
          name: 'company_name', value: _toStringOrNull(companyName));

  Future<void> _setUserIsAdmin(dynamic admin) async =>
      _analytics.setUserProperty(name: 'admin', value: _toStringOrNull(admin));

  Future<void> _setUserRole(dynamic role) async =>
      _analytics.setUserProperty(name: 'role', value: _toStringOrNull(role));

  Future<void> _setUserVerified(dynamic verified) async => _analytics
      .setUserProperty(name: 'verified', value: _toStringOrNull(verified));

  Future<void> _setUserBanned(dynamic banned) async => _analytics
      .setUserProperty(name: 'banned', value: _toStringOrNull(banned));

  Future<void> _setUserManagerType(dynamic managerType) async =>
      _analytics.setUserProperty(
          name: 'manager_type', value: _toStringOrNull(managerType));

  Future<void> _setUserActive(dynamic active) async => _analytics
      .setUserProperty(name: 'active', value: _toStringOrNull(active));

  Future<void> _setUserSfParentId(dynamic sfParentId) async =>
      _analytics.setUserProperty(
          name: 'sf_parent_id', value: _toStringOrNull(sfParentId));

  Future<void> _setUserSfAccountId(dynamic sfAccountId) async =>
      _analytics.setUserProperty(
          name: 'sf_account_id', value: _toStringOrNull(sfAccountId));

  Future<void> _setUserSfContactId(dynamic sfContactId) async =>
      _analytics.setUserProperty(
          name: 'sf_contact_id', value: _toStringOrNull(sfContactId));

  Future<void> _setUserAfContactId(dynamic afContactId) async =>
      _analytics.setUserProperty(
          name: 'af_contact_id', value: _toStringOrNull(afContactId));

  Future<void> _setUserPosition(dynamic position) async => _analytics
      .setUserProperty(name: 'position', value: _toStringOrNull(position));

  Future<void> _setUserAddress(dynamic address) async => _analytics
      .setUserProperty(name: 'address', value: _toStringOrNull(address));

  Future<void> _setUserParentCompanyName(dynamic parentCompanyName) async =>
      _analytics.setUserProperty(
          name: 'parent_company_name',
          value: _toStringOrNull(parentCompanyName));

  Future<void> _setUserPrimaryAccountId(dynamic primaryAccountId) async =>
      _analytics.setUserProperty(
          name: 'primary_account_id', value: _toStringOrNull(primaryAccountId));

  Future<void> _setUserZip(dynamic zip) async =>
      _analytics.setUserProperty(name: 'zip', value: _toStringOrNull(zip));

  Future<void> _setUserState(dynamic state) async =>
      _analytics.setUserProperty(name: 'state', value: _toStringOrNull(state));

  Future<void> _setUserCompanySite(dynamic companySite) async =>
      _analytics.setUserProperty(
          name: 'company_site', value: _toStringOrNull(companySite));

  Future<void> _clearAllSuper() async {
    await _setUserId(null);
    await _analytics.setUserProperty(name: 'email', value: null);
    await _analytics.setUserProperty(name: 'first_name', value: null);
    await _analytics.setUserProperty(name: 'last_name', value: null);
    await _analytics.setUserProperty(name: 'company_name', value: null);
    await _analytics.setUserProperty(name: 'admin', value: null);
    await _analytics.setUserProperty(name: 'role', value: null);
    await _analytics.setUserProperty(name: 'verified', value: null);
    await _analytics.setUserProperty(name: 'banned', value: null);
    await _analytics.setUserProperty(name: 'manager_type', value: null);
    await _analytics.setUserProperty(name: 'active', value: null);
    await _analytics.setUserProperty(name: 'sf_parent_id', value: null);
    await _analytics.setUserProperty(name: 'sf_account_id', value: null);
    await _analytics.setUserProperty(name: 'sf_contact_id', value: null);
    await _analytics.setUserProperty(name: 'af_contact_id', value: null);
    await _analytics.setUserProperty(name: 'position', value: null);
    await _analytics.setUserProperty(name: 'address', value: null);
    await _analytics.setUserProperty(name: 'parent_company_name', value: null);
    await _analytics.setUserProperty(name: 'primary_account_id', value: null);
    await _analytics.setUserProperty(name: 'zip', value: null);
    await _analytics.setUserProperty(name: 'state', value: null);
    await _analytics.setUserProperty(name: 'company_site', value: null);
  }

  Future<void> _logUserSuperProperties(LogMessage message) async {
    switch (message.eventName) {
      case LogMessage.createAccountButtonClick:
        await _logCreateAccount(message.propertyValues?['companyName']);
        break;

      case LogMessage.logOutButtonClick:
        await _clearAllSuper();
        break;

      case LogMessage.loginSuccessful:
        await _setUserId(_toStringOrNull(message.propertyValues?['id']));
        await _setUserEmail(_toStringOrNull(message.propertyValues?['email']));
        await _setUserFirstName(
            _toStringOrNull(message.propertyValues?['first_name']));
        await _setUserLastName(
            _toStringOrNull(message.propertyValues?['last_name']));
        await _setUserCompanyName(
            _toStringOrNull(message.propertyValues?['company_name']));
        await _setUserIsAdmin(message.propertyValues?['admin']);
        await _setUserRole(message.propertyValues?['role']);
        await _setUserVerified(message.propertyValues?['verified']);
        await _setUserBanned(message.propertyValues?['banned']);
        await _setUserManagerType(message.propertyValues?['manager_type']);
        await _setUserActive(message.propertyValues?['active']);
        await _setUserSfParentId(message.propertyValues?['sf_parent_id']);
        await _setUserSfAccountId(message.propertyValues?['sf_account_id']);
        await _setUserSfContactId(message.propertyValues?['sf_contact_id']);
        await _setUserAfContactId(message.propertyValues?['af_contact_id']);
        await _setUserSfContactId(message.propertyValues?['sf_contact_id']);
        await _setUserPosition(message.propertyValues?['position']);
        await _setUserAddress(message.propertyValues?['address']);
        await _setUserParentCompanyName(
            message.propertyValues?['parent_company_name']);
        await _setUserPrimaryAccountId(
            message.propertyValues?['primary_account_id']);
        await _setUserZip(message.propertyValues?['zip']);
        await _setUserCompanySite(message.propertyValues?['company_site']);
        await _setUserState(message.propertyValues?['state']);
        break;

      default:
        break;
    }
  }

  void _init() {
    _setSessionTimeoutDuration();
  }
}
