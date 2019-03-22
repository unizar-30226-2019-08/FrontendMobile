import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

class RatingSlider extends StatefulWidget {
  final Function(double) onMinRatingChanged;  
  
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
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w300
            ),
          )
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: width/1.5,
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
              width: width/4,
              child: Row(
                children: <Widget>[
                  Text(
                    _minRate.toStringAsFixed(0) + ' ',
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w300
                    )
                  ),
                  Icon(Icons.star , color: Colors.pink, size: 30.0)
                ],
              ),
            )
          ],
        ),
      ],
    );
  }
}