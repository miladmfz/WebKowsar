import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Broker {

  @JsonKey(name: "BrokerCode") final String BrokerCode;
  @JsonKey(name: "CentralRef") final String CentralRef;
  @JsonKey(name: "BrokerNameWithoutType") final String BrokerNameWithoutType;
  @JsonKey(name: "FactorCount") final String FactorCount;
  @JsonKey(name: "Stack") final String Stack;
  @JsonKey(name: "CustomerCount") final String CustomerCount;



  Broker({
    required this.BrokerCode,
    required this.CentralRef,
    required this.BrokerNameWithoutType,
    required this.FactorCount,
    required this.Stack,
    required this.CustomerCount,
  });

}