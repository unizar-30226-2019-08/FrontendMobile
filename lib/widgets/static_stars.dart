/*
 * FICHERO:     static_stars.dart
 * DESCRIPCIÓN: visor de valoracion en estrallas
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';

/*
  CLASE: StaticStars
  DESCRIPCIÓN: widget de visor de valoraciones en estrellas

 */
class StaticStars extends StatelessWidget {
  final double _rating;
  final Color _color;
  final int _reviews;

  // 0.0 <= _rating <= 10.0, 0 <= reviews
  StaticStars(this._rating, this._color, this._reviews);

  /*
    Pre: index > 0 e index < 6
    Post: devuelve el icono correspondiente según su posición en la lista
          determinada por 'index'
 */
  Widget buildStars(BuildContext context, int index) {
    double decimalR = _rating / 2;
    Icon icon;
    if (index >= decimalR) {
      icon = Icon(Icons.star_border, color: _color);
    } else if (index > decimalR - 1 && index < decimalR) {
      icon = Icon(Icons.star_half, color: _color);
    } else {
      icon = Icon(Icons.star, color: _color);
    }

    return icon;
  }

  /*
  Pre: ---
  Post: devuelve el número de valoraciones formateado
 */
  String getReviews() {
    String number = (this._reviews).toString();
    String r = "(" + number + ")";
    return r;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      children: <Widget>[
        Row(children: List.generate(5, (index) => buildStars(context, index))),
        Padding(
            padding: const EdgeInsets.only(left: 3),
            child: Text(
              this._reviews != null ? getReviews() : '',
              style: TextStyle(
                color: this._color,
              ),
            ))
      ],
    ));
  }
}
