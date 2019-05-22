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
  bool isForSale;
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
  @JsonKey(name: 'tiene_tags')
  List<String> tags;

  Product.empty() {
    this.id = 0;
    this.name = "";
    this.price = 0;
    this.isForSale = true;
    this.images = [];
    this.description = '';
    this.includesShipping = false;
    this.state = 'Usado';
    this.favorites = 0;
    this.lat = 0;
    this.lng = 0;
    this.tags = [];
    this.isbn = '';
  }

  Product(
      this.id,
      this.name,
      this.price,
      this.isForSale,
      this.images,
      this.description,
      this.includesShipping,
      this.state,
      this.favorites,
      this.lat,
      this.lng,
      this.tags,
      this.isbn);

  String getName() {
    return this.name;
  }

  double getPrice() {
    return this.price;
  }

  bool checkfForSale() {
    return this.isForSale;
  }

  List<String> getImages() {
    return List.generate(this.images.length,
        (i) => "https://bookalo.es/" + this.images.elementAt(i));
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

  void setName(String _name) {
    this.name = _name;
  }

  void setDesciption(String _description) {
    this.description = _description;
  }

  void setIsbn(String _isbn) {
    this.isbn = _isbn;
  }

  void setState(String _state) {
    this.state = _state;
  }

  String getISBN() {
    return this.isbn;
  }

  void insertTag(t) {
    this.tags.add(t);
  }

  void setPrice(double _price) {
    this.price = _price;
  }

  void deleteTag(_tag) {
    this.tags.remove(_tag);
  }

  String getTagsToString() {
    if (this.tags.length == 0) {
      return '';
    }
    String s = tags.first;
    for (int i = 1; i < tags.length; i++) {
      s = s + ',' + this.tags[i];
    }
    return s;
  }

  void setShippingIncluded(bool sendInclude) {
    this.includesShipping = sendInclude;
  }

  void setPosition(LatLng position){
    this.lat = position.latitude;
    this.lng = position.longitude;
  }

  String getStringShippinIncluded() {
    return (this.includesShipping) ? "Con envio" : "Sin envio";
  }

  factory Product.fromJson(Map<String, dynamic> json) {
    json['tiene_tags'] = (json['tiene_tags'] as List)
        .map((m) =>
            m.values.toString().substring(1, m.values.toString().length - 1))
        .toList();
    json['contenido_multimedia'] = (json['contenido_multimedia'] as List)
        .map((m) =>
            m.values.toString().substring(1, m.values.toString().length - 1))
        .toList();
    return _$ProductFromJson(json);
  }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
