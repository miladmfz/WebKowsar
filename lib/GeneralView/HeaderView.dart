import 'package:flutter/material.dart';
import 'package:kowsarweb/page/ReportPage.dart';
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
            width: 100.0,
          ),
          Image.network('http://87.107.78.234:60005/img/logo.png'),
          SizedBox(
            width: 10.0,
          ),
          Text(
            'مدیریت نرم افزار موبایلی کوثر',
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            width: 250.0,
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
                width: 30,
              ),
              widget.HeaderPage == "2"
                  ? HeaderNav(
                      text: 'گزارشات',
                      selected: true,
                      Pagenumber: widget.HeaderPage,
                    )
                  : HeaderNav(
                      text:'گزارشات',
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
            ? Text(
                widget.text,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                ),
              )
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
                child: Text(
                  widget.text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 11.0,
                  ),
                ),
              ),
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
