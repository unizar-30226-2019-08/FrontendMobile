/*
 * FICHERO:     rating_slider.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceSlider
 * CREACIÓN:    17/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

/*
*  CLASE:        RatingSlider
*  DESCRIPCIÓN:  widget para la selección de la mínima calificación de
*                usuarios de los que se desea obtener productos en el filtrado
*/
class RatingSlider extends StatefulWidget {
  final Function(double) onMinRatingChanged;

  /*
   * Pre:   onMinRatingChanged es una función void
   * Post:  ha construido el widget de tal forma que en cada
   *        cambio en la calificacción seleccionada, ha ejecutado
   *        la callback onMinRatingChanged
   */
  RatingSlider({Key key, this.onMinRatingChanged}) : super(key: key);

  _RatingSliderSate createState() => _RatingSliderSate();
}

class _RatingSliderSate extends State<RatingSlider> {
  double _minRate = 4.0;
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
                divisions: 4,
                min: 1.0,
                max: 5.0,
                value: _minRate,
                onChanged: (newValue) {
                  setState(() => _minRate = newValue);
                  widget.onMinRatingChanged(newValue);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: width / 4,
              child: Row(
                children: <Widget>[
                  Text(_minRate.toStringAsFixed(0) + ' ',
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
