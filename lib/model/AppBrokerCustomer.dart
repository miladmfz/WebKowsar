import 'package:json_annotation/json_annotation.dart';
part 'AppBrokerCustomer.g.dart';

@JsonSerializable()
class AppBrokerCustomer {

  @JsonKey(name: "AppBrokerCustomerCode") final String appBrokerCustomerCode;
  @JsonKey(name: "ActivationCode") final String activationCode;
  @JsonKey(name: "EnglishCompanyName") final String englishCompanyName;
  @JsonKey(name: "PersianCompanyName") final String persianCompanyName;
  @JsonKey(name: "ServerURL") final String serverURL;
  @JsonKey(name: "SQLiteURL") final String sQLiteURL;
  @JsonKey(name: "MaxDevice") final String maxDevice;

  AppBrokerCustomer({
      required this.appBrokerCustomerCode,
      required this.activationCode,
      required this.englishCompanyName,
      required this.persianCompanyName,
      required this.serverURL,
      required this.sQLiteURL,
      required this.maxDevice});

  factory AppBrokerCustomer.fromJson(Map<String, dynamic> json) =>
      _$AppBrokerCustomerFromJson(json);

  Map<String, dynamic> toJson() => _$AppBrokerCustomerToJson(this);




}