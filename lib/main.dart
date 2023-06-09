import 'package:flutter/material.dart';
import 'package:kowsarweb/page/HomePage.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      fontFamily: 'iransans',
    ),
    debugShowCheckedModeBanner: false,
    home: MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        body: HomePage(),
      ),
    );
  }
}
