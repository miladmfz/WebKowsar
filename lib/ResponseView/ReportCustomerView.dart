import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/CustomerForosh.dart';
import 'package:kowsarweb/model/NumberFunction.dart';

import '../model/AppBrokerCustomer.dart';

class ReportCustomerView extends StatefulWidget {
  ReportCustomerView({Key? key}) : super(key: key);

  //String teststr;

  @override
  State<ReportCustomerView> createState() => _ReportCustomerViewState();
}

class _ReportCustomerViewState extends State<ReportCustomerView> {
  List<CustomerForosh>  CustomerForoshs= [];
  String _teststr = "";

  void getAppBrokerCustomers() {
    if (CustomerForoshs.length == 0) {
      var url =
          "http://192.168.1.219:60005/login/index.php?tag=GetCustomerForosh";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          CustomerForoshs.clear();
          List JsonTemp = convert.jsonDecode(response.body);


          for (int i = 0; i < JsonTemp.length; i++) {

            setState(() {
              CustomerForoshs.add(new CustomerForosh(
                  CustomerCode: JsonTemp[i]["CustomerCode"],
                  Name: JsonTemp[i]["Name"],
                  Teedad: JsonTemp[i]["Teedad"],
                  MTakhfifPercent: JsonTemp[i]["MTakhfifPercent"],
                  Mablagh: JsonTemp[i]["Mablagh"],
                  TakhfifPrice: JsonTemp[i]["TakhfifPrice"],
                  nMablagh: '',
                  PriceTip: JsonTemp[i]["PriceTip"]));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (CustomerForoshs.isEmpty) {
      getAppBrokerCustomers();
    }

    return CustomerForoshs.length > 0
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
              "گزارش فروش مشتریان",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: CustomerForoshs.length,
              itemBuilder: ListColumn,
            ),
            SizedBox(
              height: 100,
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

    var thisView=MediaQuery.of(context).size.width*0.63;
    return Container(
        height: 34,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: thisView*0.034,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "$index".farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: thisView*0.25,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      ""+CustomerForoshs[index].Name.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: thisView*0.25,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      ""+CustomerForoshs[index].Teedad.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: thisView*0.17,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      ""+CustomerForoshs[index].Mablagh.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 28,
                  child: VerticalDivider(
                    thickness: 1,
                    width: 1,
                    color: Colors.black,
                  ),
                ),
                Container(
                  width: thisView *0.24,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      ""+ CustomerForoshs[index].CustomerCode.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
