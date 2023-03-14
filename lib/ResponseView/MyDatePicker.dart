
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:jalali_calendar/jalali_calendar.dart';
import 'package:kowsarweb/model/GpsLocation.dart';
import 'package:latlong2/latlong.dart';
import 'package:syncfusion_flutter_charts/charts.dart';


import '../model/MarkerDetails.dart';


class MyDatePicker extends StatefulWidget {
  @override
  _MyDatePickerState createState() => _MyDatePickerState();
}

class _MyDatePickerState extends State<MyDatePicker> {
  late TextEditingController _yearController;
  late TextEditingController _monthController;
  late TextEditingController _dayController;
  late TextEditingController _hourController;

  @override
  void initState() {
    super.initState();
    _yearController = TextEditingController();
    _monthController = TextEditingController();
    _dayController = TextEditingController();
    _hourController = TextEditingController();
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
    return Row(
      children: [
        SizedBox(
          width: 60,
          child: TextField(
            controller: _yearController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Year'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: TextField(
            controller: _monthController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Month'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: TextField(
            controller: _dayController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Day'),
          ),
        ),
        SizedBox(width: 10),
        SizedBox(
          width: 60,
          child: TextField(
            controller: _hourController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: 'Hour'),
          ),
        ),
      ],
    );
  }
}