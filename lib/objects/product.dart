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
  @JsonKey(name: 'tiene_tags')
  List<String> tags;

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
    return List.generate(this.images.length, (i) => "https://bookalo.es/" + this.images.elementAt(i));
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

  factory Product.fromJson(Map<String, dynamic> json){
    json['tiene_tags'] =
        (json['tiene_tags'] as List)
            .map((m) => m.values.toString().substring(1, m.values.toString().length -1))
            .toList();
    json['contenido_multimedia'] =
        (json['contenido_multimedia'] as List)
            .map((m) => m.values.toString().substring(1, m.values.toString().length -1))
            .toList();    
      return _$ProductFromJson(json);
    }
  Map<String, dynamic> toJson() => _$ProductToJson(this);
}
