/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'dart:math';
import 'package:bookalo/objects/product.dart';
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/utils/objects_generator.dart';

/*
 *  CLASE:        Sell
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de venta. Contiene una lista con las miniaturas
  *               de los productos del rpopio usuario que tiene a
  *               la venta.
 */
class Sell extends StatefulWidget {
  bool _hasSellProducts;

  Sell({Key key}) : super(key: key) {
    this._hasSellProducts = Random().nextDouble() > 0.2;
  }

  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  bool alreadyChecked = false;

  /*
   * Pre:   pageNumber >=0 y pageSize > 0
   * Post:  devuelve una lista con pageSize MiniProduct
   */
  Future<List<Widget>> _fetchPage(int pageSize, double height) async {
    await Future.delayed(Duration(seconds: 1));
    if (widget._hasSellProducts) {
      return List<MiniProduct>.generate(8, (index) {
        return MiniProduct(generateRandomProduct());
      });
    } else {
      if (!alreadyChecked) {
        alreadyChecked = true;
        return List.of([
          Center(
            child: Container(
              margin: EdgeInsets.only(top: height / 5),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: height / 25),
                      child: Icon(Icons.remove_shopping_cart,
                          size: 80.0, color: Colors.pink)),
                  Text(
                    Translations.of(context).text("no_products_available"),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          )
        ]);
      } else {
        return List.of([]);
      }
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "add", //todo: ver formato tags
              child: Icon(Icons.add),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadProduct()));
              },
            ),
          ],
        ),
        body: Pagination<Widget>(
          scrollDirection: Axis.vertical,
          progress: Container(
              margin: EdgeInsets.symmetric(vertical: height / 20),
              child: BookaloProgressIndicator()),
          pageBuilder: (currentSize) => _fetchPage(currentSize, height),
          itemBuilder: (index, item) {
            return item;
          },
        ));
  }
}
