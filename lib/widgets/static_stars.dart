import 'package:flutter/material.dart';

class StaticStars extends StatelessWidget {
  final int rating;
  final Color color;

  StaticStars(this.rating, this.color);

  @override
  Widget buildStars(BuildContext context, int index) {
    double decimal_r=rating/2;
    Icon icon;
    if(index>=decimal_r){
      icon = new Icon(
          Icons.star_border,
          color: color
      );
    } else if(index > decimal_r -1 && index < decimal_r){
      icon = new Icon(
          Icons.star_half,
          color: color
      );
    }else{
      icon = new Icon(
          Icons.star,
          color: color
      );
    }

    return icon;
  }

  @override
  Widget build(BuildContext context) {
      return Container(
       margin: EdgeInsets.all(10.0),
        child: Row(
            children: new List.generate(5, (index) => buildStars(context, index))
        ),
      );
      //return new Row(children: new List.generate(5, (index) => buildStars(context, index)));

  }

}