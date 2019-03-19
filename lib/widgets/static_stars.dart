import 'package:flutter/material.dart';
//TODO:Cambiar a español
class StaticStars extends StatelessWidget {
  final double rating;
 // final double width;
  final Color color;
  final int reviews;
  //TODO: sin margenes, definir cuando se use

  StaticStars(this.rating, this.color,this.reviews);//,this.width);

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
  String getReviews(){
    String number=(this.reviews).toString();
    String r="("+number+")";
    return r;
  }

  @override
  Widget build(BuildContext context) {
      return Container(
      // margin: EdgeInsets.all(10.0),
        child:Row(
          children: <Widget>[
            Row(
                children: new List.generate(5, (index) => buildStars(context, index))
            ),
             Text( this.reviews!=null ? getReviews() : '',
                  style: TextStyle(
                  color: this.color,
              ),
              )


          ],

        )



      );

  }

}