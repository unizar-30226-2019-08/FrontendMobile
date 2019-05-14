/*
 * FICHERO:     product.dart
 * DESCRIPCIÓN: clase Product
 * CREACIÓN:    15/03/2019
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:latlong/latlong.dart';

part 'product.g.dart';

/*
  CLASE: Product
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un producto
                de la aplicacion
 */
@JsonSerializable()
class Product {
  @JsonKey(name: 'pk')
  int id;
  @JsonKey(name: 'nombre')
  String name;
  @JsonKey(name: 'precio')
  double price;
  @JsonKey(name: 'estado_producto')
  String state;
  @JsonKey(name: 'num_likes')
  int favorites;
  @JsonKey(name: 'tipo_envio')
  bool includesShipping;
  @JsonKey(name: 'estado_venta')
  bool isSold;
  @JsonKey(name: 'contenido_multimedia')
  List<String> images;
  @JsonKey(name: 'descripcion')
  String description;
  @JsonKey(name: 'latitud')
  double lat;
  @JsonKey(name: 'longitud')
  double lng;
  @JsonKey(name: 'isbn')
  String isbn;
  List<String> tags;

//TODO: Constructor con ISBN
  Product(
      this.id,
      this.name,
      this.price,
      this.isSold,
      this.images,
      this.description,
      this.includesShipping,
      this.state,
      this.favorites,
      this.lat,
      this.lng,
      this.tags){
        this.isbn = null;
      }

  String getName() {
    return this.name;
  }

  double getPrice() {
    return this.price;
  }

  bool getSold() {
    return this.isSold;
  }

  List<String> getImages() {
    return this.images;
  }

  String getDescription() {
    return this.description;
  }

  String priceToString() {
    if (this.price % 1 == 0) {
      return this.price.toStringAsFixed(0) + '€';
    } else {
      return this.price.toStringAsFixed(2) + '€';
    }
  }

  LatLng getPosition() {
    return LatLng(lat, lng);
  }

  bool isShippingIncluded() {
    return this.includesShipping;
  }

  int getFavourites() {
    return this.favorites;
  }

  String getState() {
    return this.state;
  }

  List<String> getTags() {
    return this.tags;
  }


  int getId() {
    return this.id;
  }

  void setName(String _name){
    this.name = _name;
    print("nombre de prd " + this.name);
  }

 void setDesciption(String _desc){
    this.description = _desc;
  }

  void setIsbn(String _isbn){
    this.name = _isbn;
  }

  void setState(String _state){
    this.state = _state;
    print("estado del producto " + this.state);
  }
  String getISBN(){
    return this.isbn;
  }

  void insertTag(t){
    this.tags.add(t);
  }

  void setPrice(double p){
    this.price = p;
  }
  void deleteTag(t){
    this.tags.remove(t);
  }

  String getTagsToString(){
    if(this.tags.length == 0){
      return '';
    }
    String s = tags.first;
    for(int i = 1; i< tags.length; i++){
      s = s + ',' + this.tags[i];
    }
    return s;
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}

