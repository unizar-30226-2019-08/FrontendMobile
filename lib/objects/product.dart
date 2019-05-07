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

  List<String> getImages(){return this._images;}

  void setImages(List<String> value) {
    this._images = value;
  }

  String getImage(){
    return this._images.first;
  } //TODO: ver cual es la imagen principal

  int getLikes(){return this._likes;}

  void setLikes(int value) {
    this._likes = value;
  }

  String getDescription(){ return this._description;}

  void setDescription(String value) {
    this._description = value;
  }

  bool getSending() {return this._sending; }

  void setSending(bool value) {
    this._sending = value;
  }

  LatLng getPosition() {return  this._position;}

  void setPosition(LatLng value) {
    this._position = value;
  }

  String getSellStatus() {return  this._sStatus;}

  void setSellStatus(String value) {
    this._sStatus = value;
  }

  String getProductStatus() {return this._pStatus;}

  void SetProductStatus(String value) {
    this._pStatus = value;
  }

  double getPrice() {return this._price;}

  void setPrice(double value) {
    this._price = value;
  }

  String getName(){ return  this._name; }

  void setName(String value) {
    this._name = value;
  }

  bool getSold(){
    return this._sStatus == "Vendido";
  } //TODO: ver cuales son los valores de estado de venta

  String priceToString() {
    if (this._price % 1 == 0) {
      return this._price.toStringAsFixed(0) + '€';
    } else {
      return this._price.toStringAsFixed(2) + '€';
    }
  }


}