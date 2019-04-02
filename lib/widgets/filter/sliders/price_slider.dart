/*
 * FICHERO:     price_slider.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceSlider
 * CREACIÓN:    17/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        PriceSlider
 *  DESCRIPCIÓN:  widget para la selección del rango de precios en
 *                el que se desea obtener productos en el filtrado
 */
class PriceSlider extends StatefulWidget {
  final Function(double, double) onPriceChanged; 

  /*
   * Pre:   onPriceChanged es una función void
   * Post:  ha construido el widget de tal forma que en cada
   *        cambio en el rango de precios, ha ejecutado
   *        la callback onPriceChanged
   */ 
  PriceSlider({Key key, this.onPriceChanged}) : super(key: key);

  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  double _maxPrice = 80.0;
  double _minPrice = 20.0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
      Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          Translations.of(context).text("price_range"),
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.w300
          ),
        )
      ),            
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(
              width: width/7,
              child: Text(
                _minPrice.toStringAsFixed(0) + ' €',
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w300
                )
              ),
            ),                
            Container(
              width: width/1.8,
              child: new RangeSlider(
                min: 1.0,
                max: 100.0,
                lowerValue: _minPrice,
                upperValue: _maxPrice,
                showValueIndicator: true,
                valueIndicatorMaxDecimals: 1,
                onChanged: (double newLowerValue, double newUpperValue){
                  setState(() {
                    _minPrice = newLowerValue;
                    _maxPrice = newUpperValue;
                  });
                  widget.onPriceChanged(newLowerValue, newUpperValue);
                },
              ),
            ),
            Container(
              width: width/7,
              child: Text(
                _maxPrice.toStringAsFixed(0) + '€',
                style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w300
                )
              ),
            )                
          ],
        ),
      ),
      ],
    );
  }
}