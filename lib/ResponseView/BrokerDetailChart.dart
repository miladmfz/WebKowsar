import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/BrokerDetailReport.dart';
import 'package:kowsarweb/model/NumberFunction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BrokerDetailChart extends StatefulWidget {
  BrokerDetailChart({
    Key? key,
    required this.BrokerCode,
  }) : super(key: key);
  String BrokerCode;

  @override
  State<BrokerDetailChart> createState() => _BrokerDetailChartState();
}

class _BrokerDetailChartState extends State<BrokerDetailChart> {
  List<BrokerDetailReport> Daily_ChartData = [];

  List<BrokerDetailReport> Weekly_customer = [];
  List<BrokerDetailReport> Weekly_day = [];

  List<BrokerDetailReport> month_customer = [];
  List<BrokerDetailReport> month_day = [];

  TooltipBehavior tb_Daily_customer_amount = TooltipBehavior(enable: true);
  TooltipBehavior tb_Daily_customer_Price = TooltipBehavior(enable: true);

  TooltipBehavior tb_Weekly_customer_amount = TooltipBehavior(enable: true);
  TooltipBehavior tb_Weekly_customer_Price = TooltipBehavior(enable: true);
  TooltipBehavior tb_Weekly_day_amount = TooltipBehavior(enable: true);
  TooltipBehavior tb_Weekly_day_Price = TooltipBehavior(enable: true);

  TooltipBehavior tb_month_customer_amount = TooltipBehavior(enable: true);
  TooltipBehavior tb_month_customer_Price = TooltipBehavior(enable: true);
  TooltipBehavior tb_month_day_amount = TooltipBehavior(enable: true);
  TooltipBehavior tb_month_day_Price = TooltipBehavior(enable: true);

  void GetDaily() {
    if (Daily_ChartData.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetCDCustName&BrokerCode=${widget.BrokerCode}&Days=1";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          Daily_ChartData.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              Daily_ChartData.add(new BrokerDetailReport(
                  PreFactorDate: JsonTemp[i]["PreFactorDate"],
                  SumPrice: JsonTemp[i]["SumPrice"],
                  SumAmount: JsonTemp[i]["SumAmount"],
                  CustName: JsonTemp[i]["CustName"]));
            });
          }
        }
      });
    }
  }

  void GetWeeklu() {
    if (Weekly_customer.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetCDCustName&BrokerCode=${widget.BrokerCode}&Days=7";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          Weekly_customer.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              Weekly_customer.add(new BrokerDetailReport(
                  PreFactorDate: JsonTemp[i]["PreFactorDate"],
                  SumPrice: JsonTemp[i]["SumPrice"],
                  SumAmount: JsonTemp[i]["SumAmount"],
                  CustName: JsonTemp[i]["CustName"]));
            });
          }
        }
      });
    }

    if (Weekly_day.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetCDPreFactorDate&BrokerCode=${widget.BrokerCode}&Days=7";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          Weekly_day.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              Weekly_day.add(new BrokerDetailReport(
                  PreFactorDate: JsonTemp[i]["PreFactorDate"],
                  SumPrice: JsonTemp[i]["SumPrice"],
                  SumAmount: JsonTemp[i]["SumAmount"],
                  CustName: JsonTemp[i]["CustName"]));
            });
          }
        }
      });
    }
  }

  void Getmounth() {
    if (month_customer.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetCDCustName&BrokerCode=${widget.BrokerCode}&Days=30";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          month_customer.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              month_customer.add(new BrokerDetailReport(
                  PreFactorDate: JsonTemp[i]["PreFactorDate"],
                  SumPrice: JsonTemp[i]["SumPrice"],
                  SumAmount: JsonTemp[i]["SumAmount"],
                  CustName: JsonTemp[i]["CustName"]));
            });
          }
        }
      });
    }

    if (month_day.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetCDPreFactorDate&BrokerCode=${widget.BrokerCode}&Days=30";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          month_day.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              month_day.add(new BrokerDetailReport(
                  PreFactorDate: JsonTemp[i]["PreFactorDate"],
                  SumPrice: JsonTemp[i]["SumPrice"],
                  SumAmount: JsonTemp[i]["SumAmount"],
                  CustName: JsonTemp[i]["CustName"]));
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
    GetDaily();
    GetWeeklu();
    Getmounth();

    return SingleChildScrollView(
        child: Container(
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
          Container(
            width: thisView_width,
            child: Row(children: [
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Daily (Customer_Amount)'),
                    tooltipBehavior: tb_Daily_customer_amount,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Daily_ChartData,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumAmount),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Daily (Customer_Price)'),
                    tooltipBehavior: tb_Daily_customer_Price,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Daily_ChartData,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumPrice),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: thisView_width,
            child: Row(children: [
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'weekly (Customer_Amount)'),
                    tooltipBehavior: tb_Weekly_customer_amount,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Weekly_customer,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumAmount),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'weekly (Customer_Price)'),
                    tooltipBehavior: tb_Weekly_customer_Price,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Weekly_customer,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumPrice),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: thisView_width,
            child: Row(children: [
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'weekly (Day_Amount)'),
                    tooltipBehavior: tb_Weekly_day_amount,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Weekly_day,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumAmount),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'weekly (Day_Price)'),
                    tooltipBehavior: tb_Weekly_day_Price,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: Weekly_day,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumPrice),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: thisView_width,
            child: Row(children: [
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Month (Customer_Amount)'),
                    tooltipBehavior: tb_month_customer_amount,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: month_customer,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumAmount),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Month (Customer_Price)'),
                    tooltipBehavior: tb_month_customer_Price,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: month_customer,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumPrice),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            width: thisView_width,
            child: Row(children: [
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Month (Day_Amount)'),
                    tooltipBehavior: tb_month_day_amount,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: month_day,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumAmount),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
              Container(
                  width: thisView_width * 0.5,
                  color: Colors.white,
                  child: SfCartesianChart(
                    title: ChartTitle(text: 'Month (Day_Price)'),
                    tooltipBehavior: tb_month_day_Price,
                    series: <ChartSeries>[
                      LineSeries<BrokerDetailReport, String>(
                          name: 'بازاریاب ',
                          dataSource: month_day,
                          xValueMapper: (BrokerDetailReport rp, _) =>
                              rp.CustName.farsiNumber,
                          yValueMapper: (BrokerDetailReport rp, _) =>
                              double.parse(rp.SumPrice),
                          dataLabelSettings: DataLabelSettings(isVisible: true),
                          enableTooltip: true)
                    ],
                    primaryXAxis: CategoryAxis(
                      placeLabelsNearAxisLine: false,
                      edgeLabelPlacement: EdgeLabelPlacement.shift,
                    ),
                    primaryYAxis: NumericAxis(
                      labelFormat: '{value}',
                    ),
                  )),
            ]),
          ),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    ));
  }
}
