// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) {
  return Product(
      json['pk'] as int,
      json['nombre'] as String,
      (json['precio'] as num)?.toDouble(),
      json['estado_venta'] as bool,
      (json['contenido_multimedia'] as List)?.map((e) => e as String)?.toList(),
      json['descripcion'] as String,
      json['tipo_envio'] as bool,
      json['estado_producto'] as String,
      json['num_likes'] as int,
      (json['latitud'] as num)?.toDouble(),
      (json['longitud'] as num)?.toDouble(),
      (json['tiene_tags'] as List)?.map((e) => e as String)?.toList());
}

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'pk': instance.id,
      'nombre': instance.name,
      'precio': instance.price,
      'estado_producto': instance.state,
      'num_likes': instance.favorites,
      'tipo_envio': instance.includesShipping,
      'estado_venta': instance.isForSale,
      'contenido_multimedia': instance.images,
      'descripcion': instance.description,
      'latitud': instance.lat,
      'longitud': instance.lng,
      'tiene_tags': instance.tags
    };
