/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Procduct
 * CREACIÓN:    15/03/2019
 */

import 'package:lipsum/lipsum.dart' as lipsum;

/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */
class Product {
  String _name;
  double _price;
  String _state;
  int _likes;
  bool _ship;
  bool _sold;
  String _image;
  String _description;

  Product(this._name, this._price, this._sold, this._image, this._description,this._ship,this._state,this._likes);

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
  String isShipped(){
      if(this._ship){
    return "Con envío";
      }
      else{
        return "Sin envío";
      }
  }

  String getState(){
    return this._state;
  }

  int getLikes(){
    return this._likes;
  }
}
