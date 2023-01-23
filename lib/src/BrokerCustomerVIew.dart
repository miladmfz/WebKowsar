import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/NumberFunction.dart';

import '../model/AppBrokerCustomer.dart';

class BrokerCustomer extends StatefulWidget {
  @override
  State<BrokerCustomer> createState() => _BrokerCustomerState();
}

class _BrokerCustomerState extends State<BrokerCustomer> {
  List<AppBrokerCustomer> AppBrokerCustomers = [];

  void getAppBrokerCustomers() {
    if (AppBrokerCustomers.length == 0) {
      var url =
          "http://192.168.1.219:60005/login/index.php?tag=GetAppBrokerCustomer";

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
    if (AppBrokerCustomers.length < 1) {
      getAppBrokerCustomers();
    }
    return AppBrokerCustomers.length > 0
        ? SingleChildScrollView(
            child: Container(
              width: 300,
              //height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  SizedBox(height: 20,),
                  Text(
                    "لیست نرم افزار های کوثر",
                    style: GoogleFonts.nunito(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: AppBrokerCustomers.length,
                      itemBuilder: ListColumn)
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
    //print(AppBrokerCustomers[index].englishCompanyName);
    return Container(
        height: 30,
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
                  width: 30,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "$index".farsiNumber,
                      style: GoogleFonts.nunito(
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
                  width: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      AppBrokerCustomers[index].persianCompanyName.farsiNumber,
                      style: GoogleFonts.nunito(
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
                  width: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      AppBrokerCustomers[index].englishCompanyName.farsiNumber,
                      style: GoogleFonts.nunito(
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
                  width: 100,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      AppBrokerCustomers[index].activationCode.farsiNumber,
                      style: GoogleFonts.nunito(
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
                  width: 200,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      server.farsiNumber,
                      style: GoogleFonts.nunito(
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
