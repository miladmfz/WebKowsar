
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class BrokerPreFactor {



  @JsonKey(name: "SumPrice") final String SumPrice;
  @JsonKey(name: "RowsCount") final String RowsCount;
  @JsonKey(name: "SumAmount") final String SumAmount;
  @JsonKey(name: "CustName") final String CustName;

  BrokerPreFactor({
    required this.SumPrice,
    required this.RowsCount,
    required this.SumAmount,
    required this.CustName
  });



}

