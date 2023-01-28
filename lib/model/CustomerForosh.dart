import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class CustomerForosh {


  @JsonKey(name: "CustomerCode") final String CustomerCode;
  @JsonKey(name: "Name") final String Name;
  @JsonKey(name: "Teedad") final String Teedad;
  @JsonKey(name: "MTakhfifPercent") final String MTakhfifPercent;
  @JsonKey(name: "Mablagh") final String Mablagh;
  @JsonKey(name: "TakhfifPrice") final String TakhfifPrice;
  @JsonKey(name: "nMablagh") final String nMablagh;
  @JsonKey(name: "PriceTip") final String PriceTip;

  CustomerForosh({
    required this.CustomerCode,
    required this.Name,
    required this.Teedad,
    required this.MTakhfifPercent,
    required this.Mablagh,
    required this.TakhfifPrice,
    required this.nMablagh,
    required this.PriceTip});



}