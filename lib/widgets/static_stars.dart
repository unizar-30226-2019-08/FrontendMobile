import 'package:flutter/material.dart';
//Camiar a español
//TODO: añadir parentesis con numero valoraciones
class StaticStars extends StatelessWidget {
  final int rating;
 // final double width;
  final Color color;
  final int reviews;

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
     //  width: width,
       margin: EdgeInsets.all(10.0),
        child:Row(

          children: <Widget>[
            Row(
                children: new List.generate(5, (index) => buildStars(context, index))
            ),
            Padding(
              padding: const EdgeInsets.only(left: 3),
              child: Text(
                  getReviews(),
                  style: TextStyle(
                  color: this.color,
              ),
              )

            )
          ],

        )



      );

  }

}