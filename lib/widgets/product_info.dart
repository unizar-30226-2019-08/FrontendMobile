/*
 * FICHERO:     Product_info.dart
 * DESCRIPCIÓN: Características del producto
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
   double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
 
  
 return new SizedBox(
   width:width,
   height:height/5,
    child:new Row(
  children: <Widget>[


    //Columna de estado
    new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(Translations.of(context).text("state"),textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold),),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.getState(context),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        this._product.stateIcon()//Icono de estado
       
      ],
    )
    
  ),
),
      new VerticalDivider(width:2.0,color:Colors.black,indent:3.0),
    

    //Columna de envío
     new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
      
        new Text(Translations.of(context).text("ships"),textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        new Padding(padding:EdgeInsets.all(8.0),),
        this._product.shipping()==true ?  new Text(Translations.of(context).text("include_shipping"),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)):
         new Text(Translations.of(context).text("not_shipping"),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
       this._product.shippingIcon()
        
        
        
      ],
    ),
  ),
),


 new VerticalDivider(width:2.0,color:Colors.black,indent:3.0),


  //Columna de Favoritos
   new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(Translations.of(context).text("favourite"),textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.getFavourites().toString(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        new Icon(Icons.favorite)
      ],
    ),
  ),
),
  ],
    )
);
  }
}
