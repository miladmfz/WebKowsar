import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/Broker.dart';
import 'package:kowsarweb/model/NumberFunction.dart';

class BrokerDetailPanelView extends StatefulWidget {
  BrokerDetailPanelView(
      {Key? key, required this.BrokerCode, required this.SetBrokerDetailPage})
      : super(key: key);
  String BrokerCode;
  final SetBrokerDetailPage;

  @override
  State<BrokerDetailPanelView> createState() => _BrokerDetailPanelView();
}

class _BrokerDetailPanelView extends State<BrokerDetailPanelView> {
  List<Broker> Brokers = [];

  void GetBrokerDetail() {
    print(widget.BrokerCode);
    if (Brokers.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetBrokerDetail&BrokerCode=${widget.BrokerCode}";

      http.get(Uri.parse(url)).then((response) {
        print(response.statusCode);

        if (response.statusCode == 200) {
          Brokers.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              Brokers.add(new Broker(
                BrokerCode: JsonTemp[i]["BrokerCode"],
                CentralRef: JsonTemp[i]["CentralRef"],
                BrokerNameWithoutType: JsonTemp[i]["BrokerNameWithoutType"],
                FactorCount: JsonTemp[i]["FactorCount"],
                Stack: JsonTemp[i]["Stack"],
                CustomerCount: JsonTemp[i]["CustomerCount"],
              ));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (Brokers.isEmpty) {
      GetBrokerDetail();
    }

    return Brokers.length > 0
        ? SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black, width: 2),
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(2)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.width * 0.014),
                  Container(
                    margin: EdgeInsets.all(10),
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Column(
                      children: [
                        SizedBox(height: 10),
                        Container(
                          width: 100,
                          child: Center(
                            child: Image.network(
                                'http://87.107.78.234:60005/img/KowsarSupport.png'),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Center(
                            child: Text(
                              Brokers[0].BrokerNameWithoutType.farsiNumber,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Column(
                            children: [
                              _buildInfoRow(
                                  icon: Icons.person_pin,
                                  label: 'کد بازاریابی',
                                  value: Brokers[0].BrokerCode.farsiNumber),
                              _buildInfoRow(
                                  icon: Icons.build,
                                  label: 'کد اجزای پایه',
                                  value: Brokers[0].CentralRef.farsiNumber),
                              _buildInfoRow(
                                  icon: Icons.storage,
                                  label: 'انبار',
                                  value: Brokers[0].Stack.farsiNumber),
                              _buildInfoRow(
                                  icon: Icons.people,
                                  label: 'تعداد مشتریان',
                                  value: Brokers[0].CustomerCount.farsiNumber),
                              _buildInfoRow(
                                  icon: Icons.receipt,
                                  label: 'کد فاکتور روزانه',
                                  value: Brokers[0].FactorCount.farsiNumber),
                            ],
                          ),
                        ),
                        SizedBox(height: 20),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.bar_chart,size: 32),
                                onPressed: () {
                                  widget.SetBrokerDetailPage("1");
                                },
                                tooltip: 'View Chart',
                              ),
                              SizedBox(width: 16.0),
                              IconButton(
                                icon: Icon(Icons.list,size: 32),
                                onPressed: () {
                                  widget.SetBrokerDetailPage("2");
                                },
                                tooltip: 'View List',
                              ),
                              SizedBox(width: 16.0),
                              IconButton(
                                icon: Icon(Icons.location_on,size: 32),
                                onPressed: () {
                                  widget.SetBrokerDetailPage("3");
                                },
                                tooltip: 'Location',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
  }

  Widget _buildInfoRow(
      {required IconData icon, required String label, required String value}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 14,
                    fontFamily: 'Montserrat',
                  ),
                ),
                Text(
                  value,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
