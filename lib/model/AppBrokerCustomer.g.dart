// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AppBrokerCustomer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppBrokerCustomer _$AppBrokerCustomerFromJson(Map<String, dynamic> json) =>
    AppBrokerCustomer(
      appBrokerCustomerCode: json['AppBrokerCustomerCode'] as String,
      activationCode: json['ActivationCode'] as String,
      englishCompanyName: json['EnglishCompanyName'] as String,
      persianCompanyName: json['PersianCompanyName'] as String,
      serverURL: json['ServerURL'] as String,
      sQLiteURL: json['SQLiteURL'] as String,
      maxDevice: json['MaxDevice'] as String,
    );

Map<String, dynamic> _$AppBrokerCustomerToJson(AppBrokerCustomer instance) =>
    <String, dynamic>{
      'AppBrokerCustomerCode': instance.appBrokerCustomerCode,
      'ActivationCode': instance.activationCode,
      'EnglishCompanyName': instance.englishCompanyName,
      'PersianCompanyName': instance.persianCompanyName,
      'ServerURL': instance.serverURL,
      'SQLiteURL': instance.sQLiteURL,
      'MaxDevice': instance.maxDevice,
    };
