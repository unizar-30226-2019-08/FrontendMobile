/*
 * FICHERO:     filter.dart
 * DESCRIPCIÓN: clases relativas al la página de filtrado
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:flutter_tags/selectable_tags.dart';
import 'package:bookalo/widgets/filter/distance_map.dart';
import 'package:bookalo/widgets/filter/sliders/distance_slider.dart';
import 'package:bookalo/widgets/filter/sliders/price_slider.dart';
import 'package:bookalo/widgets/filter/sliders/rating_slider.dart';
import 'package:bookalo/widgets/filter/tags_loader.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        Filter
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de filtrado.
 *                Permite el ajuste de varios widgets de selección dispuestos
 *                en una lista
 */
class Filter extends StatefulWidget {
  Filter({Key key}) : super(key: key);

  _FilterState createState() => _FilterState();
}

class _FilterState extends State<Filter> {
  double _maxDistance = 10.0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          title: Text(Translations.of(context).text("filter_title"),
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300)),
          leading: Icon(Icons.sort),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.done),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ),
        body: Form(
          child: ListView(
            children: <Widget>[
              TagsLoader(
                onTagsChanged: (tag) {
                  if (tag.active) {
                    ScopedModel.of<FilterQuery>(context).addTag(tag.title);
                  } else {
                    ScopedModel.of<FilterQuery>(context).removeTag(tag.title);
                  }
                },
                initialTags: List.generate(
                    ScopedModel.of<FilterQuery>(context).tagList.length, (i) {
                  return Tag(
                      title: ScopedModel.of<FilterQuery>(context)
                          .tagList
                          .elementAt(i),
                      active: true);
                }),
              ),
              DistanceSlider(
                onMaxDistanceChange: (maxDistance) {
                  setState(() {
                    _maxDistance = maxDistance;
                  });
                },
              ),
              DistanceMap(
                  height: height / 5, distanceRadius: _maxDistance * 1000),
              PriceSlider(),
              RatingSlider(),
            ],
          ),
        ));
  }
}
