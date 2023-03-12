import 'package:flutter/material.dart';
import 'package:kowsarweb/Panel/BrokerPanelView.dart';
import 'package:kowsarweb/ResponseView/AllBroker.dart';
import 'package:kowsarweb/ResponseView/BrokersView.dart';

import '../ResponseView/BrokerCustomerVIew.dart';
import '../GeneralView/HeaderView.dart';
import '../Panel/MainPanelView.dart';
import '../ResponseView/ReportGoodsView.dart';

class Brokerpage extends StatefulWidget {
  const Brokerpage({Key? key}) : super(key: key);

  @override
  State<Brokerpage> createState() => _BrokerpageState();
}

class _BrokerpageState extends State<Brokerpage> {
  String Statestr = '1';

  void SetBrokerPage(newNumber) {
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
                HeaderPage: "2"
              ),
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                //height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width*0.03),
                    Container(
                      width: MediaQuery.of(context).size.width*0.254,
                      color: Colors.grey[200],
                      child: BrokerPanelView(
                          teststr: Statestr, SetBrokerPage: SetBrokerPage),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.014),
                    Container(
                      width: MediaQuery.of(context).size.width*0.68,
                      color: Colors.grey[200],
                      child: BrokersView(),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*0.021),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ]),
          ),
        ));
  }
}
