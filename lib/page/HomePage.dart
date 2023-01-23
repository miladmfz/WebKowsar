import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../src/BrokerCustomerVIew.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: <Widget>[
          Container(
            width: 750,
            color: Colors.grey[200],
            child:  BrokerCustomer(),
          ),
          Container(
            width: MediaQuery.of(context).size.width - 750,
            color: Colors.grey[200],
          )
        ],
      ),
    );
  }
}
