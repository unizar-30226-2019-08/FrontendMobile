import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/screens/filter.dart';
import 'package:bookalo/widgets/radial_button.dart';

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
          child: RadialButton()
        )
      );
    }
    return Scaffold(
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton.extended(
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