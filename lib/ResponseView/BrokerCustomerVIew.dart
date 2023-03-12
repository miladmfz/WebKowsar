import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/NumberFunction.dart';

import '../model/AppBrokerCustomer.dart';

class BrokerCustomer extends StatefulWidget {
  BrokerCustomer({Key? key}) : super(key: key);

  //String teststr;

  @override
  State<BrokerCustomer> createState() => _BrokerCustomerState();
}

class _BrokerCustomerState extends State<BrokerCustomer> {
  List<AppBrokerCustomer> AppBrokerCustomers = [];
  String _teststr = "";

  void getAppBrokerCustomers() {
    if (AppBrokerCustomers.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetAppBrokerCustomer";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          AppBrokerCustomers.clear();
          List JsonTemp = convert.jsonDecode(response.body);
          AppBrokerCustomers.add(new AppBrokerCustomer(
              appBrokerCustomerCode: "1",
              activationCode: "کد نرم افزار",
              englishCompanyName: "عنوان لاتین",
              persianCompanyName: "عنوان فارسی",
              serverURL: "http://آدرس سرور:60005/login/",
              sQLiteURL: "",
              maxDevice: ""));

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              AppBrokerCustomers.add(new AppBrokerCustomer(
                  appBrokerCustomerCode: JsonTemp[i]["AppBrokerCustomerCode"],
                  activationCode: JsonTemp[i]["ActivationCode"],
                  englishCompanyName: JsonTemp[i]["EnglishCompanyName"],
                  persianCompanyName: JsonTemp[i]["PersianCompanyName"],
                  serverURL: JsonTemp[i]["ServerURL"],
                  sQLiteURL: JsonTemp[i]["SQLiteURL"],
                  maxDevice: JsonTemp[i]["MaxDevice"]));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (AppBrokerCustomers.isEmpty) {
      getAppBrokerCustomers();
    }

    return AppBrokerCustomers.length > 0
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
              FittedBox(
                fit: BoxFit.contain,
                child:Text(
                    "لیست نرم افزار های کوثر",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: AppBrokerCustomers.length,
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
    var server = AppBrokerCustomers[index].serverURL.substring(
        AppBrokerCustomers[index].serverURL.indexOf("http://") + 7,
        AppBrokerCustomers[index].serverURL.indexOf(":60005"));
    var thisView = MediaQuery.of(context).size.width * 0.63;
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
                  width: thisView * 0.034,

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      "$index".farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,

                      ),),
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
                  width: thisView * 0.25,

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        AppBrokerCustomers[index]
                            .persianCompanyName
                            .farsiNumber,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w800,
                        ),
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
                  width: thisView * 0.25,

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      AppBrokerCustomers[index].englishCompanyName.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,

                      ),
                    ),),
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
                  width: thisView * 0.17,

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      AppBrokerCustomers[index].activationCode.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,

                      ),
                    ),),
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
                  width: thisView * 0.3,

                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      server.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
