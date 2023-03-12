import 'package:flutter/material.dart';
import 'package:kowsarweb/model/AppInfo.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/NumberFunction.dart';
import '../model/AppBrokerCustomer.dart';

class AllBroker extends StatefulWidget {
   AllBroker({Key? key}) : super(key: key);

  @override
  State<AllBroker> createState() => _AllBrokerState();
}

class _AllBrokerState extends State<AllBroker> {
  List<AppInfo> AppInfos = [];


  void GetAllBrokers() {
    if (AppInfos.length == 0) {
      var url =
          "http://87.107.78.234:60005/login/index.php?tag=GetAllBrokers";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          AppInfos.clear();
          List JsonTemp = convert.jsonDecode(response.body);
          AppInfos.add(new AppInfo(
              Infocode: "0",
              Device_Id: "شناسه دستگاه",
              Address_Ip: "آدرس مجموعه",
              Server_Name: "نام مجموعه",
              Factor_Code: "فاکتور فعال",
              StrDate: "تاریخ",
              Broker: "بازاریاب",
              BrokerStr: "بازاریاب ها"));

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              AppInfos.add(new AppInfo(
                  Infocode: "",
                  Device_Id: "",
                  Address_Ip: "",
                  Server_Name: JsonTemp[i]["Server_Name"],
                  Factor_Code: "",
                  StrDate: "",
                  Broker: "",
                  BrokerStr: JsonTemp[i]["BrokerStr"]));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (AppInfos.isEmpty) {
      GetAllBrokers();

    }
     return AppInfos.length > 0
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
              "لیست بازاریاب های فعال",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: AppInfos.length,
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

    var  NewbrokerStr = "";
    if(AppInfos[index].BrokerStr.length>40){
      NewbrokerStr=AppInfos[index].BrokerStr.substring(0,40)+"...";
    }else{
      NewbrokerStr=AppInfos[index].BrokerStr;
    }


    var Seperator = (AppInfos[index].BrokerStr.split(",").length );
    var thisView_width = MediaQuery.of(context).size.width * 0.67;

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
                  width: 30,
                  child: Center(
                    child:FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                      "$index".farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
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
                  width: thisView_width*0.25,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      AppInfos[index].Server_Name.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
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
                  width: thisView_width*0.2,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      Seperator.toString().farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
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
                  width: thisView_width*0.4,
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child:Text(
                      NewbrokerStr.farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                      ),
                    ),)
                  ),
                ),
              ],
            )
          ],
        ));
  }

}
