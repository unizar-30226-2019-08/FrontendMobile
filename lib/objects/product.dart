/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Procduct
 * CREACIÓN:    15/03/2019
 */

import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:json_annotation/json_annotation.dart';
import 'package:geo/geo.dart';


/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */

//enum productStatusClass { Nuevo, SemiNuevo, Usado, Antiguedad, Roto, Desgastado}
//enum saleStatusClass { EnVenta, Reservado, Vendido}
//TODO: enum o String??

@JsonSerializable()

class Product {
  String _name;
  double _price;
  String _pStatus;
  String _sStatus;
  LatLng _position;
  bool _sending; //true: envio a domicilio
  String _description;
  //User _seller; TODO: usuario en producto??
  //Tags
  int _likes;
  List<String> _images;


  Product(this._name, this._price, this._pStatus, this._sStatus, this._position,
      this._sending, this._description, this._likes, this._images);

  factory Product.fromJson(Map<String, dynamic> json){
    return Product(
      json['nombre'], double.parse(json['precio']), json['estado_producto'],
        json['estado_venta'],LatLng(num.parse(json['latitud']),
        num.parse(json['longitud'])),json['tipo_envio'],json['descripcion'],
        int.parse(json['num_likes']), json['contenido_multimedia']
    );
    //TODO: bool sending en json??
    //TODO: lista multimedia json??



  }

  List<String> get images => _images;

  set images(List<String> value) {
    _images = value;
  }

  String getImage(){
    return _images.first;
  }
  int get likes => _likes;

  set likes(int value) {
    _likes = value;
  }

  String get description => _description;

  set description(String value) {
    _description = value;
  }

  bool get sending => _sending;

  set sending(bool value) {
    _sending = value;
  }

  LatLng get position => _position;

  set position(LatLng value) {
    _position = value;
  }

  String get sStatus => _sStatus;

  set sStatus(String value) {
    _sStatus = value;
  }

  String get pStatus => _pStatus;

  set pStatus(String value) {
    _pStatus = value;
  }

  double get price => _price;

  set price(double value) {
    _price = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  bool getSold(){
    return this.sStatus == "Vendido";
  }

  String priceToString() {
    if (this._price % 1 == 0) {
      return this._price.toStringAsFixed(0) + '€';
    } else {
      return this._price.toStringAsFixed(2) + '€';
    }
  }


}