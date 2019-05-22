/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/utils/http_utils.dart';

/*
 *  CLASE:        Sell
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de venta. Contiene una lista con las miniaturas
  *               de los productos del rpopio usuario que tiene a
  *               la venta.
 */
class Sell extends StatefulWidget {
  Sell();

  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  bool endReached = false;
  bool firstFecth = true;
  /*
   * Pre:   pageNumber >=0 y pageSize > 0
   * Post:  devuelve una lista con pageSize MiniProduct
   */
  Future<List<Widget>> fetchOwnProducts(currentSize, height) async {
    List<Widget> output = new List();
    if (!endReached) {
      List<MiniProduct> fetchResult = await parseOwnProducts(currentSize, 10);
      output.addAll(fetchResult);
      endReached = fetchResult.length == 0;
      if (endReached) {
        if (firstFecth) {
          output.add(Container(
            margin: EdgeInsets.only(top: 150.0, left: 70.0, right: 70.0),
            child: Column(
              children: <Widget>[
                Icon(Icons.add_shopping_cart, size: 80.0, color: Colors.pink),
                Text(
                  Translations.of(context).text('no_productos_uploaded'),
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                )
              ],
            ),
          ));
        }
      }
      if (firstFecth) {
        firstFecth = false;
      }
    }
    return output;
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
          pageBuilder: (currentSize) => fetchOwnProducts(currentSize, height),
          itemBuilder: (index, item) {
            return item;
          },
        ));
  }
}
