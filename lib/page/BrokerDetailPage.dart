import 'package:flutter/material.dart';
import 'package:kowsarweb/GeneralView/HeaderView.dart';
import 'package:kowsarweb/Panel/BrokerDetailPanelView.dart';
import 'package:kowsarweb/ResponseView/BrokerDetailChart.dart';
import 'package:kowsarweb/ResponseView/BrokerDetailListView.dart';
import 'package:kowsarweb/ResponseView/BrokerDetailMap.dart';

class BrokerDetailPage extends StatefulWidget {
  BrokerDetailPage({Key? key, required this.BrokerCode}) : super(key: key);
  String BrokerCode;

  @override
  State<BrokerDetailPage> createState() => _BrokerDetailPageState();
}

class _BrokerDetailPageState extends State<BrokerDetailPage> {
  String Statestr = '1';

  void SetBrokerDetailPage(newNumber) {
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
              HeaderView(HeaderPage: "2"),
              SizedBox(height: 15),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.254,
                      color: Colors.grey[200],
                      child: BrokerDetailPanelView(
                        BrokerCode: widget.BrokerCode,
                        SetBrokerDetailPage: SetBrokerDetailPage,
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.014),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: (Statestr == "1")
                              ? BrokerDetailChart(BrokerCode: widget.BrokerCode)
                              : (Statestr == "2")
                                  ? BrokerDetailListView(
                                      BrokerCode: widget.BrokerCode)
                                  : BrokerDetailMap(
                                      BrokerCode: widget.BrokerCode)),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.021),
                  ],
                ),
              ),
              SizedBox(height: 15),
            ]),
          ),
        ));
  }
}
