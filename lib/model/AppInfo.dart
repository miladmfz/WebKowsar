import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class AppInfo {


  @JsonKey(name: "Infocode") final String Infocode;
  @JsonKey(name: "Device_Id") final String Device_Id;
  @JsonKey(name: "Address_Ip") final String Address_Ip;
  @JsonKey(name: "Server_Name") final String Server_Name;
  @JsonKey(name: "Factor_Code") final String Factor_Code;
  @JsonKey(name: "StrDate") final String StrDate;
  @JsonKey(name: "Broker") final String Broker;
  @JsonKey(name: "BrokerStr") final String BrokerStr;

  AppInfo({
    required this.Infocode,
    required this.Device_Id,
    required this.Address_Ip,
    required this.Server_Name,
    required this.Factor_Code,
    required this.StrDate,
    required this.Broker,
    required this.BrokerStr});


}