/*
 * FICHERO:     distance_slider.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceSlider
 * CREACIÓN:    18/03/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        DistanceSlider
 *  DESCRIPCIÓN:  widget para la selección de la máxima distancia
 *                a la que se desea obtener productos en el filtrado
 */
class DistanceSlider extends StatefulWidget {
  final Function(double) onMaxDistanceChange;

  /*
   * Pre:   onMaxDistanceChange es una función void
   * Post:  ha construido el widget de tal forma que en cada
   *        cambio en la distancia seleccionada, ha ejecutado
   *        la callback onMaxDistanceChange
   */
  DistanceSlider({Key key, this.onMaxDistanceChange}) : super(key: key);

  _DistanceSliderState createState() => _DistanceSliderState();
}

class _DistanceSliderState extends State<DistanceSlider> {
  double distance;

  @override
  void initState() {
    super.initState();
    distance = ScopedModel.of<FilterQuery>(context).maxDistance;
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
              Translations.of(context).text("max_distance"),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: width / 1.5,
              child: Slider(
                min: 1.0,
                max: 150.0,
                value: distance,
                onChanged: (value) {
                  setState(() {
                    distance = value;
                  });
                  widget.onMaxDistanceChange(value);
                },
                onChangeEnd: (value) {
                  ScopedModel.of<FilterQuery>(context).setMaxDistance(value);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              width: width / 4,
              child: Text(distance.toStringAsFixed(1) + ' km',
                  style:
                      TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300)),
            )
          ],
        ),
      ],
    );
  }
}
