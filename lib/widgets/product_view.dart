/*
 * FICHERO:     product_view.dart
 * DESCRIPCIÓN: visor del producto de la apntalla principal
 * CREACIÓN:    15/03/2019
 *
 */

import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/static_stars.dart';



/*
  CLASE: ProductView
  DESCRIPCIÓN: widget de vista de producto de la pantalla principal
 */
class ProductView extends StatelessWidget{
  final Product _product;
  final double _stars;
  final int _reviews;


  ProductView(this._product, this._stars, this._reviews);

  /*
  Pre: ---
  Post: devuelve un Widget (Card) con el precio, descripcion y tags del producto
        vendido y  valoraciones del vendedor
 */
  Widget PriceCard(BuildContext context){
    return Card(  //Tarjeta 1
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black),
      ),
      child: Column(
        children: <Widget>[
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 16,top: 16, bottom: 8),
                child: Text(
                    _product.priceToString(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    )
                ),
              )
            ],
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(left: 16, bottom: 8),
            child:  Text(this._product.getName(),
              textAlign: TextAlign.justify, //TODO:descripcion
              maxLines: 5,    //TODO: ver maximo de lineas--> max BD
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 17
              ),
            ),
          ),
         Container(
            padding: EdgeInsets.only(left: 16, bottom: 8),
            child: StaticStars(this._stars, Colors.black,this._reviews),
          )
        ],
      ),
    );
  }
  /*
  Pre: ---
  Post: devuelve un Widget (Card) con la imagen y nombre del producto vendido
 */
  Widget ImageCard(BuildContext context){
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.black),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 8,
            child: Container(
              margin: EdgeInsets.all(20),
              child: Image.network(
                _product.getImage(),
                //this._product.getImage(),
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              //width: MediaQuery.of(context).size.width,
              // margin:EdgeInsets.all(10),
                child: ListTile(
                  title: Text(this._product.getName(),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      // fontSize: 40,
                    ),
                  ),
                  trailing: Icon(Icons.chat_bubble, size: 40,),
                )
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //todo: obtener dimensiones
    double width=MediaQuery.of(context).size.width* 0.7;
    double height= MediaQuery.of(context).size.height*0.7;

    return  Stack(
      overflow: Overflow.visible,
      children: <Widget>[
        Container(
          margin: EdgeInsets.only(left: width *0.5,top: height*0.01),
          height: height*0.65,
          width: width*0.75,
          child: ImageCard(context),
        ),
        Container(
          margin: EdgeInsets.only(top: height *0.1),
          height: height*0.45,
          width: width*0.65,
          child: PriceCard(context),
        )

      ],
    );
  }




}