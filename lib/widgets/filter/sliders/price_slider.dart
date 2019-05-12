/*
 * FICHERO:     price_slider.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceSlider
 * CREACIÓN:    17/03/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_range_slider/flutter_range_slider.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/filter_query.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        PriceSlider
 *  DESCRIPCIÓN:  widget para la selección del rango de precios en
 *                el que se desea obtener productos en el filtrado
 */
class PriceSlider extends StatefulWidget {


  /*
   * Pre:   onPriceChanged es una función void
   * Post:  ha construido el widget de tal forma que en cada
   *        cambio en el rango de precios, ha ejecutado
   *        la callback onPriceChanged
   */
  PriceSlider({Key key}) : super(key: key);

  _PriceSliderState createState() => _PriceSliderState();
}

class _PriceSliderState extends State<PriceSlider> {
  double minPrice;
  double maxPrice;

  @override
  void initState() {
    super.initState();
    minPrice = ScopedModel.of<FilterQuery>(context).minPrice;
    maxPrice = ScopedModel.of<FilterQuery>(context).maxPrice;
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
              Translations.of(context).text("price_range"),
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                width: width / 9,
                child: Text(
                    minPrice.toStringAsFixed(0) + '€',
                    style:
                        TextStyle(fontSize: 25, fontWeight: FontWeight.w300)),
              ),
              Container(
                width: width / 2,
                child: RangeSlider(
                  min: 0.0,
                  max: 100.0,
                  lowerValue: minPrice,
                  upperValue: maxPrice,
                  showValueIndicator: true,
                  valueIndicatorMaxDecimals: 1,
                  onChanged: (min, max){
                    setState(() {
                      minPrice = min;
                      maxPrice = max;
                    });
                  },
                  onChangeEnd: (min, max){
                    ScopedModel.of<FilterQuery>(context).setMinPrice(min);
                    ScopedModel.of<FilterQuery>(context).setMaxPrice(max);
                  },
                ),
              ),
              Container(
                width: width / 6,
                child: Text(
                    maxPrice.toStringAsFixed(0) +' €',
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300)),
              )
            ],
          ),
        ),
      ],
    );
  }
}
