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
  List<Map> images;
  @JsonKey(name: 'descripcion')
  String description;
  @JsonKey(name: 'latitud')
  double lat;
  @JsonKey(name: 'longitud')
  double lng;
  @JsonKey(name: 'tiene_tags')
  List<Map> tags;

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
      this.tags);

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
    List<String> output = List();
    this.images.forEach((x) {
      output.add('https://bookalo.es' + x['contenido_url']);
    });
    return output;
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
    List<String> output = List();
    this.tags.forEach((x) {
      output.add(x['nombre']);
    });
    return output;
  }

  int getId() {
    return this.id;
  }

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
