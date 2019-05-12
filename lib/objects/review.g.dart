// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Review _$ReviewFromJson(Map<String, dynamic> json) {
  return Review(
      json['usuario_que_valora'] == null
          ? null
          : User.fromJson(json['usuario_que_valora'] as Map<String, dynamic>),
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      json['isSeller'] as bool,
      json['producto'] == null
          ? null
          : Product.fromJson(json['producto'] as Map<String, dynamic>),
      json['comentario'] as String,
      (json['estrellas'] as num)?.toDouble());
}

Map<String, dynamic> _$ReviewToJson(Review instance) => <String, dynamic>{
      'usuario_que_valora': instance.user,
      'timestamp': instance.date?.toIso8601String(),
      'isSeller': instance.isSeller,
      'producto': instance.product,
      'comentario': instance.review,
      'estrellas': instance.stars
    };
