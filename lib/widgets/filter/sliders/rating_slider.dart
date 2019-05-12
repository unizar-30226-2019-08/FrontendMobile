/*
 * FICHERO:     rating_slider.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceSlider
 * CREACIÓN:    17/03/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/translations.dart';

/*
*  CLASE:        RatingSlider
*  DESCRIPCIÓN:  widget para la selección de la mínima calificación de
*                usuarios de los que se desea obtener productos en el filtrado
*/
class RatingSlider extends StatefulWidget {

  /*
   * Pre:   onMinRatingChanged es una función void
   * Post:  ha construido el widget de tal forma que en cada
   *        cambio en la calificacción seleccionada, se han actualizado
   *        las opciones de filtrado
   */
  RatingSlider({Key key}) : super(key: key);

  _RatingSliderSate createState() => _RatingSliderSate();
}

class _RatingSliderSate extends State<RatingSlider> {
  double rating;

  @override
  void initState() {
    super.initState();
    rating = ScopedModel.of<FilterQuery>(context).minRating.toDouble();  
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(20.0),
            child: Text(
              Translations.of(context).text("min_rating"),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: width / 1.5,
              child: Slider(
                label: Translations.of(context).text("min_rating"),
                divisions: 5,
                min: 0.0,
                max: 5.0,
                value: rating,
                onChanged: (value) {
                  setState((){
                    rating = value;
                  });
                },
                onChangeEnd: (value){
                  ScopedModel.of<FilterQuery>(context).setMinRating(value.round());
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: width / 4,
              child: Row(
                children: <Widget>[
                  Text(
                      rating.toStringAsFixed(0)+ ' ',
                      style: TextStyle(
                          fontSize: 25.0, fontWeight: FontWeight.w300)),
                  Icon(Icons.star, color: Colors.pink, size: 30.0)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}
