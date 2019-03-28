/*
 * FICHERO:     review_card.dart
 * DESCRIPCIÓN: miniatura de valoracion de transacción
 * CREACIÓN:    15/03/2019
 *
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/usuario.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/translations.dart';

/*
  CLASE: ReviewCard
  DESCRIPCIÓN: widget de miniatura de transaccion
 */
class ReviewCard extends StatelessWidget{
  final Usuario _user;
  //final int _reviewDate;
   var _reviewDate;
  final bool _seller; //true: vendió, false: compró

  //TODO: numero de valoraciones en usuario??
  final Product _product;
  final String _review;
  final double _stars;


  ReviewCard(this._user, this._reviewDate, this._seller,
      this._product, this._review, this._stars);

  //  TODO: pasar a utils
  String DateToString(DateTime f){
    String res=(f.day).toString()+'/'+(f.month).toString()+'/'+(f.year).toString();
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return  Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
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
                  child: Text(DateToString(_reviewDate),  //DateToString
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
      );


   // return null;
  }



}