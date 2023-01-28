import 'package:flutter/material.dart';
import 'package:kowsarweb/Panel/ReportPanelView.dart';
import 'package:kowsarweb/ResponseView/AllBroker.dart';
import 'package:kowsarweb/ResponseView/ReportCustomerView.dart';

import '../ResponseView/BrokerCustomerVIew.dart';
import '../GeneralView/HeaderView.dart';
import '../Panel/MainPanelView.dart';
import '../ResponseView/ReportGoodsView.dart';

class Reportpage extends StatefulWidget {
  const Reportpage({Key? key}) : super(key: key);

  @override
  State<Reportpage> createState() => _ReportpageState();
}

class _ReportpageState extends State<Reportpage> {
  String Statestr = '0';

  void SetPanelState(newNumber) {
    setState(() {
      Statestr = newNumber;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            //height: double.infinity,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              HeaderView(
                HeaderPage: "2",
              ),
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                //height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: 50),
                    Container(
                      width: MediaQuery.of(context).size.width - 970,
                      color: Colors.grey[200],
                      child: ReportPanelView(
                          teststr: Statestr, SetPanelState: SetPanelState),
                    ),
                    SizedBox(width: 20),
                    Container(
                      width: 850,
                      color: Colors.grey[200],
                      child: Statestr == "1" ? ReportGoodsView() : ReportCustomerView(),
                    ),
                    SizedBox(width: 50),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ]),
          ),
        ));
  }
}
