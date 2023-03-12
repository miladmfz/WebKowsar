import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/Broker.dart';
import 'package:kowsarweb/model/NumberFunction.dart';
import 'package:kowsarweb/page/BrokerDetailPage.dart';

class BrokersView extends StatefulWidget {
  BrokersView({Key? key}) : super(key: key);

  //String teststr;

  @override
  State<BrokersView> createState() => _BrokersView();
}

class _BrokersView extends State<BrokersView> {
  List<Broker> Brokers = [];
  String _teststr = "";

  void getBrokers() {
    if (Brokers.length == 0) {
      var url = "http://87.107.78.234:60005/login/index.php?tag=GetBrokers";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          Brokers.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              Brokers.add(new Broker(
                BrokerCode: JsonTemp[i]["BrokerCode"],
                CentralRef: JsonTemp[i]["CentralRef"],
                BrokerNameWithoutType: JsonTemp[i]["BrokerNameWithoutType"],
                FactorCount: "",
                Stack: "",
                CustomerCount: "",
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
      getBrokers();
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
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "لیست بازاریاب ها",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  GridView.builder(
                    itemCount: Brokers.length,
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: MediaQuery.of(context).size.width < 600 ?1 : 3,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 220,
                      // width / height: fixed for *all* items
                    ),
                    itemBuilder: ListColumn,
                  ),
                  SizedBox(
                    height: 50,
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

  Widget ListColumn(BuildContext context, int index) {
    return Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child:
            Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 100,
                  child: Center(
                    child: Image.network(
                        'http://87.107.78.234:60005/img/KowsarSupport.png'),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  color: Color(0x82BAE8FF),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      "" + Brokers[index].BrokerNameWithoutType.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
                  ),
                ),
                SizedBox(
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  color: Color(0x82BAE8FF),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      " کد بازاریابی : " + Brokers[index].BrokerCode.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
                  ),
                ),
                SizedBox(
                  child: Divider(
                    thickness: 1,
                    height: 1,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),

                GestureDetector(
                    onTap: () {
                      print(Brokers[index].BrokerCode);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BrokerDetailPage( BrokerCode: Brokers[index].BrokerCode)),
                      );
                    },
                    child: Container(
                      child: Center(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child:Text(
                              "جزئیات بیشتر",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w800,
                              ),
                            ),)
                      ),
                    ))

                ,
              ],
            )
          );
  }
}
