/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'package:bookalo/objects/product.dart';
import 'package:flutter/material.dart';
import 'package:paging/paging.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/empty_list.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/translations.dart';

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
      List<Product> fetchResult = await parseOwnProducts(currentSize, 10, seeErrorWith: context);
      output.addAll(fetchResult
          .map((p) => MiniProduct(p, () {/*TODO: borrarlo de la lista*/})));
      endReached = fetchResult.length == 0;
      if (endReached) {
        if (firstFecth) {
          output.add(EmptyList(
              iconData: Icons.add_shopping_cart,
              textKey: "no_products_uploaded"));
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
            FloatingActionButton.extended(
              heroTag: "addFAB",
              icon: Icon(Icons.add),
              label: Text(Translations.of(context).text('upload_product')),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => UploadProduct()));
              },
            )
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
