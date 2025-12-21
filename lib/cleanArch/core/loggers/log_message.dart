import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'log_message.g.dart';

Object? _faValue(dynamic v) {
  if (v == null) return null;
  if (v is String || v is num || v is bool) return v;
  if (v is Enum) return v.name;
  if (v is DateTime) return v.toIso8601String();
  if (v is Iterable) return v.map(_faValue).toList();
  if (v is Map) {
    return v.map((k, val) => MapEntry(k.toString(), _faValue(val)));
  }
  return v.toString();
}

Map<String, dynamic>? _propsFromJson(Map<String, dynamic>? src) {
  return src;
}

Map<String, dynamic>? _propsToJson(Map<String, dynamic>? src) {
  if (src == null) return null;
  return src.map((k, v) => MapEntry(k, _faValue(v)));
}

Object? _toEncodable(dynamic v) {
  if (v is LogMessage) {
    return <String, dynamic>{
      'appVersion': v.appVersion,
      'eventName': v.eventName,
      'message': v.message,
      'propertyValues': _faValue(v.propertyValues),
    };
  }
  return _faValue(v);
}

@JsonSerializable()
class LogMessage {
  const LogMessage({
    required this.appVersion,
    required this.eventName,
    this.message,
    @JsonKey(fromJson: _propsFromJson, toJson: _propsToJson)
    this.propertyValues,
  });

  factory LogMessage.fromJson(Map<String, dynamic> json) =>
      _$LogMessageFromJson(json);

  Map<String, dynamic> toJson() => _$LogMessageToJson(this);

  @override
  String toString() {
    return const JsonEncoder.withIndent('  ', _toEncodable).convert(this);
  }

  final String appVersion;
  final String? message;

  @JsonKey(fromJson: _propsFromJson, toJson: _propsToJson)
  final Map<String, dynamic>? propertyValues;

  final String eventName;

  static const debug = 'debug';

  static const zoneError = 'zone error';

  static const exceptionTagName = 'exception';

  static const getItInit = 'get_it_init';

  static const mainAppStart = 'main_app_start';

  static const splashScreen = 'splash_screen_view';

  static const adminScreen = 'admin_screen_view';

  static const jobDetailScreen = 'job_detail_screen_view';

  static const jobsScreen = 'jobs_screen_view';

  static const notificationsScreen = 'notifications_screen_view';

  static const settingsScreen = 'settings_screen_view';

  static const warehouseDetailScreen = 'warehouse_detail_screen_view';

  static const warehousesScreen = 'warehouses_screen_view';

  static const warehousesScreenSearchOverlayTextFieldOpen =
      'warehouses_screen_open_search_text_field';

  static const warehousesScreenSearchOverlayTextFieldClose =
      'warehouses_screen_close_search_text_field';

  static const warehousesScreenAddWarehouseBClicked =
      'warehouses_screen_add_warehouse_button_clicked';

  static const warehousesScreenSetHQ =
      'warehouses_screen_set_hq_button_clicked';

  static const warehousesScreenSetHome =
      'warehouses_screen_set_home_button_clicked';

  static const warehousesScreenActivateWarehouse =
      'warehouses_screen_activate_warehouse_button_clicked';

  static const warehousesScreenPauseWarehouse =
      'warehouses_screen_pause_warehouse_button_clicked';

  static const warehousesScreenDeleteWarehouse =
      'warehouses_screen_delete_warehouse_button_clicked';

  static const searchScreen = 'search_screen_view';

  static const changePasswordScreen = 'change_password_screen_view';

  static const accountScreen = 'account_screen_view';

  static const navBarScreen = 'nav_bar_screen_view';

  static const loginScreen = 'login_screen_view';

  static const loginSuccessful = 'login_screen_login_successful';

  static const loginError = 'login_screen_signup_error';

  static const loginScreenButtonClick = 'login_screen_bclick';

  static const companySearchByEmailButtonClick =
      'company_search_by_email_bclick';

  static const companySearchByEmailSuccess = 'company_search_by_email_success';

  static const createAccountScreen = 'create_account_screen_view';

  static const signupSuccessful = 'login_screen_signup_successful';

  static const createAccountButtonClick = 'create_accaunt_bclick';

  static const signupError = 'create_account_screen_error';

  static const logOutButtonClick = 'log_out_button_bclick';

  static const sendFeedbackButtonClick = 'send_feedback_button_bclick';
}
