/*
 * FICHERO:     buy.dart
 * DESCRIPCIÓN: clases relativas al la pestaña de compra
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/social_buttons.dart';
import 'package:bookalo/widgets/filter_options_selector.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:scoped_model/scoped_model.dart';

/*
 *  CLASE:        Buy
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de compra. Contiene una lista con los productos
 *                obtenidos según las opciones de filtrado.
 */
class Buy extends StatefulWidget {
  Buy({Key key}) : super(key: key);

  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "searchFAB",
              icon: Icon(Icons.search),
              label: Text(Translations.of(context).text('search')),
              onPressed: () {},
            ),
            SizedBox(
              height: 16.0,
            ),
            FloatingActionButton.extended(
              heroTag: "filterFAB",
              icon: Icon(Icons.sort),
              label: Text(Translations.of(context).text('filter')),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Filter()));
              },
            ),
          ],
        ),
        body: ScopedModelDescendant<FilterQuery>(
          builder: (context, child, model) {
            return new ProductListViewer(query: model);
          },
        ));
  }
}

class ProductListViewer extends StatefulWidget {
  final FilterQuery query;
  const ProductListViewer({Key key, this.query}) : super(key: key);

  @override
  _ProductListViewerState createState() => _ProductListViewerState();
}

class _ProductListViewerState extends State<ProductListViewer> {
  bool _isLoading = false;

  void fetchProducts() {
    if (!_isLoading) {
      _isLoading = true;
      parseProducts(widget.query, widget.query.queryResult.length, 10)
          .then((newProducts) {
        _isLoading = false;
        if (newProducts.isEmpty) {
          widget.query.setEndReached(true);
          if (widget.query.queryResult.length == 0) {
            newProducts.add(Center(
                child: Container(
              margin: EdgeInsets.only(top: 150),
              child: Column(
                children: <Widget>[
                  Icon(Icons.remove_shopping_cart,
                      size: 150, color: Colors.pink),
                  Container(height: 20),
                  Text(
                    Translations.of(context).text("no_products_available"),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            )));
          } else {
            newProducts.add(SocialButtons());
          }
        }
        setState(() => widget.query.queryResult.addAll(newProducts));
      }).catchError((e) {
        print(e);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        FilterOptionSelector(),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, position) {
              if (position < widget.query.queryResult.length) {
                return widget.query.queryResult[position];
              } else if (position == widget.query.queryResult.length &&
                  !widget.query.endReached) {
                fetchProducts();
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 50.0),
                    child: BookaloProgressIndicator());
              } else {
                return null;
              }
            },
          ),
        )
      ],
    );
  }
}
