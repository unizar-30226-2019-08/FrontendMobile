/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Product
 * CREACIÓN:    15/03/2019
 */

import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */
class Product {
  String _name;
  double _price;
  String _state;
  int _favourites;
  bool _ship;
  bool _sold;
  String _image;
  String _description;

  Product(this._name, this._price, this._sold, this._image, this._description,this._ship,this._state,this._favourites);

  String getName() {
    return this._name;
  }

  double getPrice() {
    return this._price;
  }

  bool getSold() {
    return this._sold;
  }

  String getImage() {
    return this._image;
  }

  String getDescription() {
    return lipsum.createSentence();
  }

  String priceToString() {
    if (this._price % 1 == 0) {
      return this._price.toStringAsFixed(0) + '€';
    } else {
      return this._price.toStringAsFixed(2) + '€';
    }
  }
  bool shipping(){
      return this._ship;
    
  }
/*Pre:Los estados posibles son: "Nuevo","Semi-Nuevo","Usado","Desgastado","Antigüedad","Roto"
 *     representado por números del 1 al 6 respectivamente
 *Post:Personaliza el icono "estado" en función del estado del producto
 */

Widget stateIcon(){
  Widget child;
  switch(this._state){
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
Widget shippingIcon(){
  Widget child;
  if(this.shipping()){
    child= new Icon(Icons.local_shipping);//si incluye envío,se imprime el camión
  }
  else {
    child=new Icon(Icons.close);//si no, se imprime la cruz
  }
  return child;
}


  String getState(BuildContext context){
    switch(this._state){
   case "Nuevo":
    return Translations.of(context).text("new");
     break;

  case "Semi-Nuevo":
    return Translations.of(context).text("Almost-new");
    break;

  case "Usado":
   return Translations.of(context).text("Used");

    break;
  case "Desgastado":
   return Translations.of(context).text("Wasted");
    break;

  case "Antigüedad":
   return Translations.of(context).text("Old");
    break;

  default:
  return Translations.of(context).text("Broken");
  break;
  }

  }

  int getFavourites(){
    return this._favourites;
  }
}
