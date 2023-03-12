import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BrokerDetailReport {



  @JsonKey(name: "PreFactorDate") final String PreFactorDate;
  @JsonKey(name: "SumPrice") final String SumPrice;
  @JsonKey(name: "SumAmount") final String SumAmount;
  @JsonKey(name: "CustName") final String CustName;

  BrokerDetailReport({
    required this.PreFactorDate,
    required this.SumPrice,
    required this.SumAmount,
    required this.CustName
  });

}