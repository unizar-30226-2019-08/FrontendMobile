import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/screens/filter.dart';

class Buy extends StatefulWidget {

  Buy({Key key}) : super(key: key);

  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {

    //MOCKUP
    List<Widget> products = [];
    for(int i = 0; i<15; i++){
      products.add(
        Card(
          child: Container(child: Center(child: Icon(Icons.shopping_cart)), height: 200.0,),
        )
      );
    }
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
            heroTag: "uniq1",
            icon: Icon(Icons.search),
            label: Text(Translations.of(context).text('search')),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Filter())
              );
            },
          ),
          SizedBox(
            height: 16.0,
          ),
          FloatingActionButton.extended(
            heroTag: "uniq2",
            icon: Icon(Icons.sort),
            label: Text(Translations.of(context).text('filter')),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Filter())
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: products
      ),
    );
  }
}