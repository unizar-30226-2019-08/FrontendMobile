/*
 * FICHERO:     filter_options_selector.dart
 * DESCRIPCIÓN: clases relativas a las opciones de filtrado
 * CREACIÓN:    17/03/2019
 */

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/objects/filter_query.dart';


/*
 * CLASE:FilterOptionSelector
 * DESCRIPCIÓN: widget que muestra los tagscon los que se ha aplicado el filtrado
 */




class FilterOptionSelector extends StatefulWidget {
  final GlobalKey productListKey;
  FilterOptionSelector({Key key, this.productListKey}) : super(key: key);

  _FilterOptionSelectorState createState() => _FilterOptionSelectorState();
}

class _FilterOptionSelectorState extends State<FilterOptionSelector> {
  @override
  Widget build(BuildContext context) {
    if (ScopedModel.of<FilterQuery>(context).isFiltering) {
      return Column(
        children: <Widget>[
          Container(
            height: 50.0,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children:
                  ScopedModel.of<FilterQuery>(context).filterOptions(context),
            ),
          ),
          OutlineButton(
            borderSide: BorderSide(color: Colors.pink, width: 3.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Text(
              Translations.of(context).text("stop_filtering"),
              style: TextStyle(
                  color: Colors.pink[600], fontWeight: FontWeight.w700),
            ),
            onPressed: () {
              ScopedModel.of<FilterQuery>(context).removeFilter();
            },
          ),
          Divider()
        ],
      );
    } else {
      return Container(height: 0.0, width: 0.0);
    }
  }
}
