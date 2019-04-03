/*
 * FICHERO:     filter.dart
 * DESCRIPCIÓN: clases relativas al la página de filtrado
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
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

class _FilterState extends State<Filter>{
  double _maxDistance = 10.0;
  @override
  Widget build(BuildContext context){
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          Translations.of(context).text("filter_title"),
          style: TextStyle(
            fontSize: 25.0,
            fontWeight: FontWeight.w300
          )),
        leading: Icon(Icons.sort),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.done),
            onPressed: (){
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      body: Form(
        child: ListView(
          children: <Widget>[
            TagsLoader(
              onTagsChanged: (tag){},
              initialTags: [],
            ),
            DistanceSlider(
              onMaxDistanceChange: (maxDistance){
                setState(() {
                  _maxDistance = maxDistance;
                });
              },
            ),
            DistanceMap(height: height/5, distanceRadius: _maxDistance*1000),            
            PriceSlider(onPriceChanged: (minPrice, maxPrice) {}),
            RatingSlider(onMinRatingChanged: (minRate){}),
            Container(
              margin: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Text(
                  '434 productos disponibles',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w300
                  ),
                )
              ),
            ),
          ],
        ),
      )
    );
  }
}