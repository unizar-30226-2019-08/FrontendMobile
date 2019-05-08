// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) {
  return User(
      json['nombre'] as String,
      json['imagen_perfil'] as String,
      json['uid'] as String,
      json['ciudad'] as String,
      (json['media_valoraciones'] as num)?.toDouble(),
      json['ultima_conexion'] == null
          ? null
          : DateTime.parse(json['ultima_conexion'] as String));
}

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'nombre': instance.displayName,
      'imagen_perfil': instance.pictureURL,
      'uid': instance.uid,
      'ciudad': instance.city,
      'media_valoraciones': instance.rating,
      'ultima_conexion': instance.lastConnection?.toIso8601String()
    };
