import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GoodsSum {


  @JsonKey(name: "GoodCode") final String GoodCode;
  @JsonKey(name: "GoodName") final String GoodName;
  @JsonKey(name: "MaxSellPrice") final String MaxSellPrice;
  @JsonKey(name: "TahvilDate") final String TahvilDate;
  @JsonKey(name: "Amount") final String Amount;
  @JsonKey(name: "MinSellPrice") final String MinSellPrice;
  @JsonKey(name: "Tiraj") final String Tiraj;
  @JsonKey(name: "GoodExplain1") final String GoodExplain1;
  @JsonKey(name: "GoodType") final String GoodType;
  @JsonKey(name: "SellPrice1") final String SellPrice1;

  GoodsSum({
    required this.GoodCode,
    required this.GoodName,
    required this.MaxSellPrice,
    required this.TahvilDate,
    required this.Amount,
    required this.MinSellPrice,
    required this.Tiraj,
    required this.GoodExplain1,
    required this.GoodType,
    required this.SellPrice1});



}