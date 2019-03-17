import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/buy_and_sell_navbar.dart';
import 'package:bookalo/screens/buy.dart';

class BuyAndSell extends StatelessWidget {

  BuyAndSell();

  @override
  Widget build(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: BuyAndSellNavbar(preferredSize: Size.fromHeight(height/5)),
        body: TabBarView(
          children: [
            Buy(),
            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}