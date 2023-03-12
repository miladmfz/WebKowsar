import 'package:flutter/material.dart';

class MainPanelView extends StatefulWidget {
  MainPanelView({Key? key, required this.teststr, required this.SetHomePageState})
      : super(key: key);
  String teststr;
  final SetHomePageState;

  @override
  State<MainPanelView> createState() => _MainPanelViewState();
}

class _MainPanelViewState extends State<MainPanelView> {
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
            height: MediaQuery.of(context).size.width * 0.014,
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                widget.SetHomePageState("1");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.teststr == "2"
                    ? Color(0xffbfc0d3)
                    : Color(0xff5c65fd),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                elevation: 4,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(2),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "لیست نرم افزار های کوثر",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          ),
          Container(
            margin: EdgeInsets.all(5),
            width: MediaQuery.of(context).size.width * 0.6,
            child: ElevatedButton(
              onPressed: () {
                widget.SetHomePageState("2");
                // Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) => AppInfoView()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: widget.teststr == "2"
                    ? Color(0xff5c65fd)
                    : Color(0xffbfc0d3),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(2),
                ),
                elevation: 4,
              ),
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "لیست  نرم افزار های فعال",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.width * 0.014,
          ),
        ],
      ),
    );
  }
}
