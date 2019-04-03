/*
 * FICHERO:     review_card.dart
 * DESCRIPCIÓN: miniatura de valoracion de transacción
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/translations.dart';

/*
  CLASE: ReviewCard
  DESCRIPCIÓN: widget de miniatura de transaccion
 */
class ReviewCard extends StatelessWidget{
  final User _user;
  //final int _reviewDate;
  final DateTime _reviewDate;
  final bool _seller; //true: vendió, false: compró

  //TODO: numero de valoraciones en usuario??
  final Product _product;
  final String _review;
  final double _stars;


  ReviewCard(this._user, this._reviewDate, this._seller,
      this._product, this._review, this._stars);

  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: EdgeInsets.all(10.0),
      child: Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(backgroundImage:
                NetworkImage(_user.getImagenPerfil())),
              title: Text(_user.getName(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 21,
                  )
                ),
              subtitle: Text(this._seller == true ? Translations.of(context).text("seller_tab")
                  : Translations.of(context).text("buyer_tab"),
                style: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 17,
                ),
              ),
              trailing:CircleAvatar(backgroundImage:
                            NetworkImage(_product.getImage())),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children :[
                Container(
                  margin:EdgeInsets.only(left: 16),
                  child: Text(dateToNumbers(_reviewDate, context),  //DateToString
                    style:TextStyle(
                      color: Colors.grey[400],
                      fontSize: 19,
                    )
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(right: 16),
                  child: StaticStars(this._stars, Colors.black,null),
                )

              ]
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(left: 16,right: 16, bottom: 20,top: 10),
                    child:  Text(this._review,
                      textAlign: TextAlign.justify,
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),

                  )
                ],
            )
          ],
        ),
      ),
    );


   // return null;
  }



}