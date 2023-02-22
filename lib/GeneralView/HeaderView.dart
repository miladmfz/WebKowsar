import 'package:flutter/material.dart';
import 'package:kowsarweb/page/BrokerPage.dart';
import 'package:kowsarweb/page/HomePage.dart';

class HeaderView extends StatefulWidget {
  const HeaderView({Key? key, required this.HeaderPage}) : super(key: key);
  final String HeaderPage;

  @override
  State<HeaderView> createState() => _HeaderViewState();
}

class _HeaderViewState extends State<HeaderView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff32a0ff),
      height: 60.0,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width*0.09,
          ),
          Image.network('http://87.107.78.234:60005/img/logo.png'),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.014,
          ),
          FittedBox(
              fit: BoxFit.contain,
              child: Text(
                'مدیریت نرم افزار موبایلی کوثر',
                style: TextStyle(color: Colors.white),
              )),
          SizedBox(
            width: MediaQuery.of(context).size.width*0.10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              widget.HeaderPage == "1"
                  ? HeaderNav(
                      text: 'صفحه اصلی',
                      selected: true,
                      Pagenumber: widget.HeaderPage,
                    )
                  : HeaderNav(
                      text: 'صفحه اصلی',
                      selected: false,
                      Pagenumber: widget.HeaderPage,
                    ),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.02,
              ),
              widget.HeaderPage == "2"
                  ? HeaderNav(
                      text: 'بازاریاب',
                      selected: true,
                      Pagenumber: widget.HeaderPage,
                    )
                  : HeaderNav(
                      text: 'بازاریاب',
                      selected: false,
                      Pagenumber: widget.HeaderPage,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

class HeaderNav extends StatefulWidget {
  String text;
  bool selected;
  String Pagenumber;

  HeaderNav(
      {required this.text, required this.selected, required this.Pagenumber});

  @override
  _HeaderNavState createState() => _HeaderNavState();
}

class _HeaderNavState extends State<HeaderNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        widget.selected
            ? FittedBox(
                fit: BoxFit.contain,
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ))
            : GestureDetector(
                onTap: () {
                  if (widget.Pagenumber == "1") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Reportpage()),
                    );
                  } else if (widget.Pagenumber == "2") {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                  }
                },
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(
                    widget.text,
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                )),
        widget.selected
            ? SizedBox(
                height: 5.0,
              )
            : SizedBox(),
        widget.selected
            ? CircleAvatar(
                backgroundColor: Colors.white,
                radius: 2.0,
              )
            : SizedBox(),
      ],
    );
  }
}
