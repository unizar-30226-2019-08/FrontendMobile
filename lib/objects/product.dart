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
  int _favorites;
  bool _includesShipping;
  bool _isSold;
  String _image;
  String _description;

  Product(this._name, this._price, this._isSold, this._image, this._description,
      this._includesShipping, this._state, this._favorites);

  String getName() {
    return this._name;
  }

  double getPrice() {
    return this._price;
  }

  bool getSold() {
    return this._isSold;
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

  bool includesShipping() {
    return this._includesShipping;
  }

  int getFavourites() {
    return this._favorites;
  }

  String getState() {
    return this._state;
  }
}
