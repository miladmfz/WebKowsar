import 'package:flutter/material.dart';
import 'package:kowsarweb/ResponseView/AllBroker.dart';
import 'package:kowsarweb/ResponseView/DownloadView.dart';

import '../GeneralView/HeaderView.dart';
import '../ResponseView/BrokerCustomerVIew.dart';
import '../panel/MainPanelView.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String Statestr = '3';

  void SetHomePageState(newNumber) {
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
                HeaderPage: "1",
              ),
              SizedBox(height: 30),
              Container(
                height: MediaQuery.of(context).size.height - 120,
                //height: double.infinity,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: <Widget>[
                    SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.254,
                      color: Colors.grey[200],
                      child: MainPanelView(
                          teststr: Statestr,
                          SetHomePageState: SetHomePageState),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.014),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.68,
                      color: Colors.grey[200],
                      child: (Statestr == "1")
                          ? BrokerCustomer()
                          : (Statestr == "2")
                              ? AllBroker()
                              : DownloadView(),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.021),
                  ],
                ),
              ),
              SizedBox(height: 30),
            ]),
          ),
        ));
  }
}
