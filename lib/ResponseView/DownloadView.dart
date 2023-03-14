import 'package:flutter/material.dart';
import 'package:kowsarweb/model/CustomerForosh.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadView extends StatefulWidget {
  DownloadView({Key? key}) : super(key: key);

  //String teststr;

  @override
  State<DownloadView> createState() => _DownloadViewState();
}

class _DownloadViewState extends State<DownloadView> {
  List<CustomerForosh> CustomerForoshs = [];
  String _teststr = "";

  static const String url1 = 'http://87.107.78.234:60005/app/Brokerkowsar.apk';
  static const String url2 = 'http://87.107.78.234:60005/app/KowsarCompany.apk';
  static const String url3 = 'http://87.107.78.234:60005/app/OcrKowsar.apk';
  static const String url4 = 'http://87.107.78.234:60005/app/OrderKowsar.apk';

  // تابعی برای باز کردن یک صفحه وب
  static Future<void> _openUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
              "Download Kowsar Application",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w800,
                fontSize: 20,
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () => _openUrl(url1),
                    child: Text(' Broker '),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _openUrl(url2),
                    child: Text('Customer'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _openUrl(url3),
                    child: Text('Ocr'),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () => _openUrl(url4),
                    child: Text('OrderKowsar۴'),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
          ],
        ),
      ),
    );
  }
}
