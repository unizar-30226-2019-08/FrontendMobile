import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/objects/filter_query.dart';

class FilterOptionSelector extends StatefulWidget {
  final GlobalKey productListKey;
  FilterOptionSelector({Key key, this.productListKey}) : super(key: key);

  _FilterOptionSelectorState createState() => _FilterOptionSelectorState();
}

class _FilterOptionSelectorState extends State<FilterOptionSelector> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<FilterQuery>(
      builder: (context, child, model) {
        if (!model.isFiltering) {
          return Container(width: 0.0, height: 0.0);
        }
        return Column(
          children: <Widget>[
            Container(
              height: 50.0,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: model.filterOptions(context),
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
                model.removeFilter();
              },
            ),
            Divider()
          ],
        );
      },
    );
  }
}
