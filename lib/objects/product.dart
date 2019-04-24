/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Product
 * CREACIÓN:    15/03/2019
 */

import 'package:latlong/latlong.dart';
/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */
class Product {
  String _name;
  double _price;
  bool _sold;
  String _image;
  String _description;
  double _lat;
  double _lng;

  Product(this._name, this._price, this._sold, this._image, this._description, this._lat, this._lng);

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
    return this._description;
  }

  String priceToString() {
    if (this._price % 1 == 0) {
      return this._price.toStringAsFixed(0) + '€';
    } else {
      return this._price.toStringAsFixed(2) + '€';
    }
  }

  LatLng getPosition(){
    return LatLng(_lat, _lng);
  }
}
