import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Broker {

  @JsonKey(name: "BrokerCode") final String BrokerCode;
  @JsonKey(name: "CentralRef") final String CentralRef;
  @JsonKey(name: "BrokerNameWithoutType") final String BrokerNameWithoutType;


  Broker({
    required this.BrokerCode,
    required this.CentralRef,
    required this.BrokerNameWithoutType,
  });

}