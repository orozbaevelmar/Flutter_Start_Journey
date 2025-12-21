// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'log_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LogMessage _$LogMessageFromJson(Map<String, dynamic> json) => LogMessage(
      appVersion: json['appVersion'] as String,
      eventName: json['eventName'] as String,
      message: json['message'] as String?,
      propertyValues:
          _propsFromJson(json['propertyValues'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$LogMessageToJson(LogMessage instance) =>
    <String, dynamic>{
      'appVersion': instance.appVersion,
      'message': instance.message,
      'propertyValues': _propsToJson(instance.propertyValues),
      'eventName': instance.eventName,
    };
