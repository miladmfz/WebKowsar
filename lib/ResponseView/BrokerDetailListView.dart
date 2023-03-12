import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/BrokerPreFactor.dart';
import 'package:kowsarweb/model/NumberFunction.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class BrokerDetailListView extends StatefulWidget {
  BrokerDetailListView({
    Key? key,
    required this.BrokerCode,
  }) : super(key: key);
  String BrokerCode;

  @override
  State<BrokerDetailListView> createState() => _BrokerDetailListViewState();
}

class _BrokerDetailListViewState extends State<BrokerDetailListView> {
  List<BrokerPreFactor> BrokerPreFactorsDaily = [];
  List<BrokerPreFactor> BrokerPreFactorsweekly = [];
  List<BrokerPreFactor> BrokerPreFactorsmonthly = [];

  TooltipBehavior tooltipBehavior = TooltipBehavior(enable: true);

  void GetBrokerFactorDaily() {
    if (BrokerPreFactorsDaily.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetPrefactorBroker&BrokerCode=${widget.BrokerCode}&Days=1";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          BrokerPreFactorsDaily.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              BrokerPreFactorsDaily.add(new BrokerPreFactor(
                SumPrice: JsonTemp[i]["SumPrice"],
                RowsCount: JsonTemp[i]["RowsCount"],
                SumAmount: JsonTemp[i]["SumAmount"],
                CustName: JsonTemp[i]["CustName"],
              ));
            });
          }
        }
      });
    }
  }

  void GetBrokerFactorweekly() {
    if (BrokerPreFactorsweekly.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetPrefactorBroker&BrokerCode=${widget.BrokerCode}&Days=7";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          BrokerPreFactorsweekly.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              BrokerPreFactorsweekly.add(new BrokerPreFactor(
                SumPrice: JsonTemp[i]["SumPrice"],
                RowsCount: JsonTemp[i]["RowsCount"],
                SumAmount: JsonTemp[i]["SumAmount"],
                CustName: JsonTemp[i]["CustName"],
              ));
            });
          }
        }
      });
    }
  }

  void GetBrokerFactormonthly() {
    if (BrokerPreFactorsmonthly.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetPrefactorBroker&BrokerCode=${widget.BrokerCode}&Days=30";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          BrokerPreFactorsmonthly.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              BrokerPreFactorsmonthly.add(new BrokerPreFactor(
                SumPrice: JsonTemp[i]["SumPrice"],
                RowsCount: JsonTemp[i]["RowsCount"],
                SumAmount: JsonTemp[i]["SumAmount"],
                CustName: JsonTemp[i]["CustName"],
              ));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var thisView_height = MediaQuery.of(context).size.height - 124;
    var thisView_width = MediaQuery.of(context).size.width * 0.67;
    GetBrokerFactorDaily();
    GetBrokerFactorweekly();
    GetBrokerFactormonthly();

    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                border: Border.all(color: Colors.black, width: 1),
              ),
              width: thisView_width,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Daily',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'ردیف',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'کد پیش فاکتور',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'تاریخ پیش فاکتور',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'تعداد ردیف',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'جمع مبلغ کل',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'جمع تعداد کل',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          BrokerPreFactorsDaily.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  "${(index + 1)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsDaily[index]
                                      .CustName
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsDaily[index]
                                      .RowsCount
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsDaily[index]
                                      .SumAmount
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsDaily[index]
                                      .SumPrice
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                border: Border.all(color: Colors.black, width: 1),
              ),
              width: thisView_width,
              child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        'Week',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                        ),
                      ),
                      DataTable(
                        columns: [
                          DataColumn(
                            label: Text(
                              'ردیف',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'کد پیش فاکتور',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'تاریخ پیش فاکتور',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'تعداد ردیف',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'جمع مبلغ کل',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              'جمع تعداد کل',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w800,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                        rows: List.generate(
                          BrokerPreFactorsweekly.length,
                          (index) => DataRow(
                            cells: [
                              DataCell(
                                Text(
                                  "${(index + 1)}",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsweekly[index]
                                      .CustName
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  "",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsweekly[index]
                                      .RowsCount
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsweekly[index]
                                      .SumAmount
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                              DataCell(
                                Text(
                                  BrokerPreFactorsweekly[index]
                                      .SumPrice
                                      .farsiNumber,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(2),
                ),
                border: Border.all(color: Colors.black, width: 1),
              ),
              width: thisView_width,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Column(
                  children: [
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Mounth',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 14,
                      ),
                    ),
                    DataTable(
                      columns: [
                        DataColumn(
                          label: Text(
                            'ردیف',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'کد پیش فاکتور',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'تاریخ پیش فاکتور',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'تعداد ردیف',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'جمع مبلغ کل',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'جمع تعداد کل',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                      rows: List.generate(
                        BrokerPreFactorsmonthly.length,
                        (index) => DataRow(
                          cells: [
                            DataCell(
                              Text(
                                "${(index + 1)}",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                BrokerPreFactorsmonthly[index]
                                    .CustName
                                    .farsiNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                               "",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                BrokerPreFactorsmonthly[index]
                                    .RowsCount
                                    .farsiNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                BrokerPreFactorsmonthly[index]
                                    .SumAmount
                                    .farsiNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            DataCell(
                              Text(
                                BrokerPreFactorsmonthly[index]
                                    .SumPrice
                                    .farsiNumber,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
