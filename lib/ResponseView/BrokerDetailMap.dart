import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kowsarweb/model/GpsLocation.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../model/MarkerDetails.dart';

class BrokerDetailMap extends StatefulWidget {
  BrokerDetailMap({
    Key? key,
    required this.BrokerCode,
  }) : super(key: key);
  String BrokerCode;

  @override
  State<BrokerDetailMap> createState() => _BrokerDetailMapState();
}

class _BrokerDetailMapState extends State<BrokerDetailMap> {
  List<GpsLocation> GpsLocations = [];
  List<Marker> Markers = [];
  List<Polyline> polylines = [];
  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();
  TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

  void getBrokerDetailMap() {
    if (GpsLocations.length == 0) {
      var url = "http://87.107.78.234:60005/login/index.php?tag=Gettracker";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          GpsLocations.clear();
          Markers.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              GpsLocations.add(new GpsLocation(
                  gpsLocationCode: JsonTemp[i]["GpsLocationCode"],
                  longitude: JsonTemp[i]["Longitude"],
                  latitude: JsonTemp[i]["Latitude"],
                  brokerRef: JsonTemp[i]["BrokerRef"],
                  gpsDate: JsonTemp[i]["GpsDate"]));

              Markers.add(
                Marker(
                  width: 10,
                  height: 10,
                  point: LatLng(
                    double.parse(JsonTemp[i]["Latitude"]),
                    double.parse(JsonTemp[i]["Longitude"]),
                  ),
                  builder: (ctx) => GestureDetector(
                    onTap: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (BuildContext context) {
                          return MarkerDetails(
                            gpsLocationCode: JsonTemp[i]["GpsLocationCode"],
                            longitude: double.parse(JsonTemp[i]["Longitude"]),
                            latitude: double.parse(JsonTemp[i]["Latitude"]),
                            brokerRef: JsonTemp[i]["BrokerRef"],
                            gpsDate: JsonTemp[i]["GpsDate"],
                          );
                        },
                      );
                    },
                    child: Container(
                      child: Container(
                        child: Center(
                          child: Image.network(
                              'http://87.107.78.234:60005/img/KowsarSupport.png'),
                        ),
                      ),
                    ),
                  ),
                ),
              );
              if (i < JsonTemp.length - 2) {
                polylines.add(Polyline(
                  points: [
                    LatLng(
                      double.parse(JsonTemp[i]["Latitude"]),
                      double.parse(JsonTemp[i]["Longitude"]),
                    ),
                    LatLng(
                      double.parse(JsonTemp[i + 1]["Latitude"]),
                      double.parse(JsonTemp[i + 1]["Longitude"]),
                    )
                  ],
                  color: Colors.blue,
                  strokeWidth: 3,
                ));
              }
            });
          }
        }
      });
    }
  }

  final MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    var thisView_height = MediaQuery.of(context).size.height - 124;
    var thisView_width = MediaQuery.of(context).size.width * 0.67;

    getBrokerDetailMap();

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(
          Radius.circular(2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${_selectedTime == null ? "" : DateFormat.Hm().format(DateTime(2022, 1, 1, _selectedTime!.hour, _selectedTime!.minute))}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Show the time picker dialog and wait for the user to select a time
                  TimeOfDay? selectedTime = await showTimePicker(
                    context: context,
                    initialTime: _selectedTime ?? TimeOfDay.now(),
                    builder: (BuildContext context, Widget? child) {
                      return MediaQuery(
                        data: MediaQuery.of(context)
                            .copyWith(alwaysUse24HourFormat: true),
                        child: child!,
                      );
                    },
                  );

                  // Update the selected time and show details
                  if (selectedTime != null) {
                    setState(() {
                      _selectedTime = selectedTime;
                    });
                  }
                },
                child: Text('Select Time'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Visibility(
                visible: _selectedDate != null,
                child: Text(
                  "${DateFormat('yyyy/MM/dd').format(_selectedDate!)}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                width: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  // Show the date picker dialog and wait for the user to select a date
                  DateTime? selectedDate = await showDatePicker(
                    context: context,
                    initialDate: _selectedDate ?? DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );

                  // Update the selected date and show details
                  if (selectedDate != null) {
                    setState(() {
                      _selectedDate = selectedDate;
                    });
                  }
                },
                child: Text('Select Date'),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Stack(
            children: [
              Container(
                // Set the decoration of the container to give it a border, background color, and rounded corners
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 1),
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
                margin: EdgeInsets.all(2),
                height: thisView_height * 0.6,
                width: thisView_width,
                child: FlutterMap(
                  options: MapOptions(
                    // Set the center of the map to a specific location and the initial zoom level
                    center: LatLng(35.70438, 51.37574),
                    zoom: 12,
                    maxZoom: 16,
                    minZoom: 10,
                  ),
                  nonRotatedChildren: [
                    // Add an attribution widget to give credit to the data source
                    AttributionWidget.defaultWidget(
                      source: 'کوثر سامانه پرداز',
                    ),
                  ],
                  children: [
                    // Add a tile layer using OpenStreetMap tiles as the source
                    TileLayer(
                      urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                    ),

                    // Add a marker layer using the markers from the Markers list
                    PolylineLayer(
                      polylines: polylines,
                    ),
                    MarkerLayer(
                      markers: Markers,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SelectedTimeWidget extends StatefulWidget {
  final TimeOfDay? selectedTime;

  SelectedTimeWidget({this.selectedTime});

  @override
  _SelectedTimeWidgetState createState() => _SelectedTimeWidgetState();
}

class _SelectedTimeWidgetState extends State<SelectedTimeWidget> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'Selected time: ${widget.selectedTime == null ? "" : widget.selectedTime!.format(context)}',
      style: TextStyle(fontSize: 20),
    );
  }
}
