import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
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

  TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);
  String StartDate = "";
  String EndDate = "";

  void getBrokerDetailMap() {
    if (GpsLocations.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=Gettracker&BrokerCode=${widget.BrokerCode}&StartDate=${StartDate}&EndDate=${EndDate}";

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
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late TextEditingController _hourController;
  TextEditingController _dateController = TextEditingController(text: '');
  TextEditingController _dateController_next = TextEditingController(text: '');

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();

    _yearController = TextEditingController();
    _monthController = TextEditingController();
    _dayController = TextEditingController();
    _hourController = TextEditingController();
    _hourController.text = '07';
    _dayController.text = '01';
    _monthController.text = '01';
    _yearController.text = "1401";
  }

  @override
  void dispose() {
    _yearController.dispose();
    _monthController.dispose();
    _dayController.dispose();
    _hourController.dispose();
    super.dispose();
  }

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
          Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            Text(
              'تاریخ و ساعت را وارد کنید',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Row(children: [
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _hourController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: InputDecoration(
                    hintText: 'HH',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Convert the input value to an integer and apply constraints
                    int inputValue = int.tryParse(value) ?? 0;
                    if (inputValue < 0) {
                      inputValue = 0;
                    } else if (inputValue > 23) {
                      inputValue = 23;
                    }
                    // Update the text field value with the sanitized input value
                    setState(() {
                      _hourController.value = TextEditingValue(
                        text: inputValue.toString(),
                        selection: TextSelection.collapsed(
                          offset: inputValue.toString().length,
                        ),
                      );
                    });
                  },
                ),
              ),
              Text(
                " : ",
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 50,
                child: TextField(
                  controller: _dayController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: InputDecoration(
                    hintText: 'MM',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Convert the input value to an integer and apply constraints
                    int inputValue = int.tryParse(value) ?? 0;
                    if (inputValue < 0) {
                      inputValue = 0;
                    } else if (inputValue > 31) {
                      inputValue = 31;
                    }
                    // Update the text field value with the sanitized input value
                    setState(() {
                      _dayController.value = TextEditingValue(
                        text: inputValue.toString(),
                        selection: TextSelection.collapsed(
                          offset: inputValue.toString().length,
                        ),
                      );
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 60,
                child: TextField(
                  controller: _monthController,
                  keyboardType: TextInputType.number,
                  maxLength: 2,
                  decoration: InputDecoration(
                    hintText: 'MM',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Convert the input value to an integer and apply constraints
                    int inputValue = int.tryParse(value) ?? 0;
                    if (inputValue < 0) {
                      inputValue = 0;
                    } else if (inputValue > 12) {
                      inputValue = 12;
                    }
                    // Update the text field value with the sanitized input value
                    setState(() {
                      _monthController.value = TextEditingValue(
                        text: inputValue.toString(),
                        selection: TextSelection.collapsed(
                          offset: inputValue.toString().length,
                        ),
                      );
                    });
                  },
                ),
              ),
              SizedBox(width: 10),
              SizedBox(
                width: 70,
                child: TextField(
                  controller: _yearController,
                  keyboardType: TextInputType.number,
                  maxLength: 4,
                  decoration: InputDecoration(
                    hintText: 'YYYY',
                    contentPadding: EdgeInsets.symmetric(horizontal: 8),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    // Convert the input value to an integer and apply constraints
                    int inputValue = int.tryParse(value) ?? 0;
                    if (inputValue < 1401) {
                      inputValue = 1401;
                    } else if (inputValue > 1402) {
                      inputValue = 1402;
                    }
                    // Update the text field value with the sanitized input value
                    setState(() {
                      _yearController.value = TextEditingValue(
                        text: inputValue.toString(),
                        selection: TextSelection.collapsed(
                            offset: inputValue.toString().length),
                      );
                    });
                  },
                ),
              ),
            ]),
          ]),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Get the values of all four text fields
                    String year = _yearController.text;
                    String month = _monthController.text.padLeft(2, '0');
                    String day = _dayController.text.padLeft(2, '0');
                    String hour = _hourController.text.padLeft(2, '0');

                    int hourValue = int.tryParse(_hourController.text) ?? 0;
                    String hournext =
                        (hourValue + 1).toString().padLeft(2, '0');

                    // Concatenate the values to create the date string
                    String dateStr = '$year/$month/$day $hour:00:00';
                    String dateStrnext = '$year/$month/$day $hournext:00:00';
                    StartDate = dateStr;
                    EndDate = dateStrnext;
                    // Set the date string values to the text fields
                    _dateController.text = dateStr;
                    _dateController_next.text = dateStrnext;
                    GpsLocations.clear();
                    Markers.clear();
                    polylines.clear();
                    getBrokerDetailMap();
                    // Print the date strings for debugging purposes
                    print(dateStr);
                    print(dateStrnext);
                  },
                  child: Text('اعمال'),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    enabled: false,
                    controller: _dateController,
                    decoration: InputDecoration(
                      hintText: 'Enter Date and Time',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: TextField(
                    enabled: false,
                    controller: _dateController_next,
                    decoration: InputDecoration(
                      hintText: 'Enter Next Date and Time',
                      contentPadding: EdgeInsets.symmetric(horizontal: 8),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
              ],
            ),
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
                  child: GpsLocations.length > 0
                      ? FlutterMap(
                          options: MapOptions(
                            // Set the center of the map to a specific location and the initial zoom level
                            center: LatLng(
                              double.parse(GpsLocations[0].latitude),
                              double.parse(GpsLocations[0].longitude),
                            ),
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
                        )
                      : Container(
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        )),
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
