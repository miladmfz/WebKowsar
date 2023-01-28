import 'package:flutter/material.dart';

class ReportPanelView extends StatefulWidget {
  ReportPanelView({Key? key, required this.teststr,required this.SetPanelState}) : super(key: key);
  String teststr;
  final SetPanelState;

  @override
  State<ReportPanelView> createState() => _ReportPanelViewState();
}

class _ReportPanelViewState extends State<ReportPanelView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 2),
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.width *0.014,
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                widget.SetPanelState("1");

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.teststr == "2"
                    ? Color(0xffbfc0d3)
                    : Color(0xff5c65fd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 15.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "موجودی کالا",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                widget.SetPanelState("2");

              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.teststr == "2"
                    ? Color(0xff5c65fd)
                    : Color(0xffbfc0d3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                elevation: 15.0,
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  "فروش مشتریان",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width *0.014,
          ),
        ],
      ),
    );
  }
}
