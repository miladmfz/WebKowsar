import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kowsarweb/model/GoodsSum.dart';
import 'package:kowsarweb/model/NumberFunction.dart';

class ReportGoodsView extends StatefulWidget {
  ReportGoodsView({Key? key}) : super(key: key);

  //String teststr;

  @override
  State<ReportGoodsView> createState() => _ReportGoodsViewState();
}

class _ReportGoodsViewState extends State<ReportGoodsView> {
  List<GoodsSum> GoodsSums = [];
  String _teststr = "";

  void GetGoodsSum() {
    if (GoodsSums.length == 0) {
      var url = "http://87.107.78.234:60005/login/index.php?tag=GetGoodsSum";

      http.get(Uri.parse(url)).then((response) {
        if (response.statusCode == 200) {
          GoodsSums.clear();
          List JsonTemp = convert.jsonDecode(response.body);

          for (int i = 0; i < JsonTemp.length; i++) {
            setState(() {
              GoodsSums.add(new GoodsSum(
                  GoodCode: JsonTemp[i]["GoodCode"],
                  GoodName: JsonTemp[i]["GoodName"],
                  MaxSellPrice: JsonTemp[i]["MaxSellPrice"],
                  TahvilDate: JsonTemp[i]["TahvilDate"],
                  Amount: JsonTemp[i]["Amount"],
                  MinSellPrice: JsonTemp[i]["MinSellPrice"],
                  Tiraj: JsonTemp[i]["Tiraj"],
                  GoodExplain1: JsonTemp[i]["GoodExplain1"],
                  GoodType: JsonTemp[i]["GoodType"],
                  SellPrice1: JsonTemp[i]["SellPrice1"]));
            });
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (GoodsSums.isEmpty) {
      GetGoodsSum();
    }

    return GoodsSums.length > 0
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
                    "گزارش موجودی کالا",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w800,
                      fontSize: 20,
                    ),
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: GoodsSums.length,
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
    var GoodName = "";
    var Amount = "";
    var Price = "";
    if (GoodsSums[index].GoodName.length > 20) {
      GoodName = GoodsSums[index].GoodName.substring(0, 20) + "...";
    } else {
      GoodName = GoodsSums[index].GoodName;
    }

    if (GoodsSums[index].MaxSellPrice.contains(".")) {
      Price = GoodsSums[index]
          .MaxSellPrice
          .substring(0, GoodsSums[index].MaxSellPrice.indexOf("."));
    } else {
      Price = GoodsSums[index].MaxSellPrice;
    }

    if (GoodsSums[index].Amount.contains(".")) {
      Amount = GoodsSums[index]
          .Amount
          .substring(0, GoodsSums[index].Amount.indexOf("."));
    } else {
      Amount = GoodsSums[index].Amount;
    }
    if (Amount.isEmpty) {
      Amount = "0";
    }

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
                  height: 30,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      "$index".farsiNumber,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w800,
                        fontSize: 12,
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
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      GoodName.farsiNumber,
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
                  width: thisView * 0.25,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      GoodsSums[index].GoodExplain1.farsiNumber,
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
                  width: thisView * 0.17,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      Price.farsiNumber,
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
                  width: thisView * 0.12,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      GoodsSums[index].GoodType.farsiNumber,
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
                  width: thisView * 0.12,
                  color: Colors.grey[300],
                  child: Center(
                    child: Text(
                      Amount.farsiNumber,
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
