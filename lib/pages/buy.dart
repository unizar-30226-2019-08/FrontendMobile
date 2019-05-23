/*
 * FICHERO:     buy.dart
 * DESCRIPCIÓN: clases relativas al la pestaña de compra
 * CREACIÓN:    13/03/2019
 */
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/social_buttons.dart';
import 'package:bookalo/widgets/filter_options_selector.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/empty_list.dart';

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
  bool showSearchBar = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "searchFAB",
              icon: Icon(Icons.search),
              backgroundColor: (showSearchBar ? Colors.pink[600] : Colors.pink),
              label: Text(Translations.of(context).text('search')),
              onPressed: () {
                setState(() => showSearchBar = !showSearchBar);
              },
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
            return new ProductListViewer(
                query: model, showSearchBar: showSearchBar);
          },
        ));
  }
}

class ProductListViewer extends StatefulWidget {
  final FilterQuery query;
  final bool showSearchBar;
  const ProductListViewer({Key key, this.query, this.showSearchBar})
      : super(key: key);

  @override
  _ProductListViewerState createState() => _ProductListViewerState();
}

class _ProductListViewerState extends State<ProductListViewer> {
  bool _isLoading = false;

  void fetchProducts() {
    if (!ScopedModel.of<FilterQuery>(context).endReached) {
      if (!_isLoading) {
        _isLoading = true;
        parseProducts(widget.query, widget.query.queryResult.length, 10, seeErrorWith: context)
            .then((newProducts) {
          _isLoading = false;
          if (newProducts.isEmpty) {
            widget.query.setEndReached(true);
            if (widget.query.queryResult.length == 0) {
              newProducts.add(EmptyList(
                  iconData: Icons.remove_shopping_cart,
                  textKey: "no_products_available"));
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
        (widget.showSearchBar ? SearchBar() : Container()),
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

class SearchBar extends StatefulWidget {
  SearchBar({Key key}) : super(key: key);

  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _controller;
  Timer timer;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(
        text: ScopedModel.of<FilterQuery>(context).querySearch);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.search, color: Colors.pink),
          title: TextField(
            onChanged: (s) {
              timer?.cancel();

              timer = Timer(Duration(milliseconds: 300), () {
                ScopedModel.of<FilterQuery>(context).setQuerySearch(s);
              });
            },
            controller: _controller,
            cursorColor: Colors.pink,
            decoration: InputDecoration(
                hintText: Translations.of(context).text("search") + "...",
                enabledBorder: InputBorder.none,
                disabledBorder: InputBorder.none),
          ),
          trailing: IconButton(
            icon: Icon(Icons.cancel, color: Colors.pink),
            onPressed: () {
              setState(() => _controller.clear());
              ScopedModel.of<FilterQuery>(context).setQuerySearch("");
            },
          ),
        ),
        Divider()
      ],
    );
  }
}
