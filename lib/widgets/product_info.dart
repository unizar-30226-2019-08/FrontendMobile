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

/*Pre:Los estados posibles son: "Nuevo","Semi-Nuevo","Usado","Antigüedad","Roto","Desgastado"
 *Post:Personaliza el icono "estado" en función del estado del producto
 */

Widget state(){
  Widget child;
  switch(this._product.getState()){
   case "Nuevo":
    child=new Icon(Icons.fiber_new);
     break;

  case "Semi-Nuevo":
    child=new Icon(Icons.sentiment_very_satisfied);
    break;

  case "Usado":
   child=new Icon(Icons.sentiment_satisfied);

    break;
  case "Desgastado":
   child=new Icon(Icons.sentiment_neutral);
    break;

  case "Antigüedad":
    child=new Icon(Icons.sentiment_dissatisfied);
    break;

  default:
  child=new Icon(Icons.sentiment_very_dissatisfied);
  break;
  }

  return child;
  
}

/*Pre:
 *Post:Personaliza el icono de la columna de envíos en función de siel producto incluye envío o no
 */
Widget ships(){
  Widget child;
  if(this._product.isSent()){
    child= new Icon(Icons.local_shipping);//si incluye envío,se imprime el camión
  }
  else {
    child=new Icon(Icons.close);//si no, se imprime la cruz
  }
  return child;
}

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
        new Text(this._product.getState(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
        
        state()
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
        this._product.isSent()==true ?  new Text(Translations.of(context).text("include_shipping"),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)):
         new Text(Translations.of(context).text("not_shipping"),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
       
        ships()
        
        
      ],
    ),
  ),
),


 new VerticalDivider(width:2.0,color:Colors.black,indent:3.0),


  //Columna de likes
   new Expanded(
  child: new Container(
    padding: new EdgeInsets.only(left: 8.0),
    child: new Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Text(Translations.of(context).text("favourite"),textAlign:TextAlign.center,style:TextStyle(fontSize:20, fontWeight: FontWeight.bold)),
        new Padding(padding:EdgeInsets.all(8.0),),
        new Text(this._product.getLikes().toString(),textAlign:TextAlign.center,style:TextStyle(fontWeight:FontWeight.w300)),
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
