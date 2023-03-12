import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class GpsLocation {

  @JsonKey(name: "gpsLocationCode") final String gpsLocationCode;
  @JsonKey(name: "longitude") final String longitude;
  @JsonKey(name: "latitude") final String latitude;
  @JsonKey(name: "brokerRef") final String brokerRef;
  @JsonKey(name: "gpsDate") final String gpsDate;

  GpsLocation({
      required this.gpsLocationCode,
      required this.longitude,
      required this.latitude,
      required this.brokerRef,
      required this.gpsDate,});


}