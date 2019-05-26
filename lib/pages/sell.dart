/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'package:bookalo/objects/product.dart';
import 'package:flutter/material.dart';
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
  bool _endReached = false;
  bool _firstFecth = true;
  bool _isLoading = false;
  List<Widget> _list;

  @override
  void initState() {
    super.initState();
    _list = [];
  }

  /*
   * Pre:   pageNumber >=0 y pageSize > 0
   * Post:  devuelve una lista con pageSize MiniProduct
   */
  void fetchOwnProducts(currentSize, height) async {
    if (!_isLoading) {
      _isLoading = true;
      List<Widget> output = new List();
      List<Product> fetchResult =
          await parseOwnProducts(currentSize, 10, seeErrorWith: context);
      output.addAll(fetchResult
          .map((p) => MiniProduct(p, () {
            print("HEEEET");
            setState(() => _list.clear());}
          )));
      _endReached = fetchResult.length == 0;
      _isLoading = false;
      if (_endReached) {
        if (_firstFecth) {
          output.add(EmptyList(
              iconData: Icons.add_shopping_cart,
              textKey: "no_products_uploaded"));
        }
      }
      if (_firstFecth) {
        _firstFecth = false;
      }
      setState(() => _list.addAll(output));
    }
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
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadProduct()));
              },
            )
          ],
        ),
        body: ListView.builder(
          itemBuilder: (context, position) {
            if (position < _list.length) {
              return _list[position];
            } else if (position == _list.length && !_endReached) {
              fetchOwnProducts(_list.length, height);
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: BookaloProgressIndicator());
            } else {
              return null;
            }
          },
        )
        );
  }
}
