/*
 * FICHERO:     product_info.dart
 * DESCRIPCIÓN: visor de miniatura del producto
 * CREACIÓN:    13/04/2019
 */

import 'package:bookalo/translations.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';

/*
  CLASE: ProductInfo
  DESCRIPCIÓN:Proporciona información del producto 
              sobre su estado, si incluye envío y el número de likes
 */

class ProductInfo extends StatelessWidget {
  final Product _product;

  ProductInfo(this._product);




  @override
  Widget build(BuildContext context) {
      
 return new SizedBox(
   width:500,
   height:100,
    child:new Row(
  children: <Widget>[
    
    new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Estado",textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.getState(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        new Icon(Icons.fiber_new)
      ],
    ),
  ),
),
      new VerticalDivider(width:2.0,color:Colors.black,indent:3.0),
    
     new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Envios",textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.isDelivered(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        new Icon(Icons.local_shipping)     
      ],
    ),
  ),
),


 new VerticalDivider(width:2.0,color:Colors.black,indent:3.0),

   new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text("Likes",textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.getLikes().toString(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        new Icon(Icons.star)
      ],
    ),
  ),
),
  ],
    )
);
  }
}
