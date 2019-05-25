import 'package:flutter/material.dart';
import 'package:bookalo/utils/miscelanea.dart';
import 'package:bookalo/objects/product.dart';

class ISBNViewer extends StatelessWidget {
  final Product product;
  final double sizeISBN;

  ISBNViewer({Key key, this.product, this.sizeISBN}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        (product.getISBN().length > 0
            ? Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "ISBN",
                      style: TextStyle(fontSize: 20),
                    ),
                    Container(height: 5),
                    Text(
                      parseISBN(product.getISBN()),
                      style:
                          TextStyle(fontSize: (sizeISBN == null) ? 35 : sizeISBN, fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              )
            : Container(height: 0)),
        (product.getISBN().length > 0 ? Divider() : Container(height: 0)),
      ],
    );
  }
}
