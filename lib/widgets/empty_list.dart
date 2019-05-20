import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

class EmptyList extends StatelessWidget {
  final IconData iconData;
  final String textKey;

  EmptyList({Key key, this.iconData, this.textKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.only(top: 120, left: 40.0, right: 40.0),
      child: Column(
        children: <Widget>[
          Icon(iconData, size: 150, color: Colors.pink),
          Container(height: 20),
          Text(
            Translations.of(context).text(textKey),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
          )
        ],
      ),
    ));
  }
}
