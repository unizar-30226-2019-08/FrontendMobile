// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
      json['texto'] as String,
      json['hora'] == null ? null : DateTime.parse(json['hora'] as String),
      json['es_suyo'] as bool,
      json['es_valoracion'] as bool,
      json['valoracion'] == null
          ? null
          : Review.fromJson(json['valoracion'] as Map<String, dynamic>));
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'texto': instance.body,
      'hora': instance.timestamp?.toIso8601String(),
      'es_suyo': instance.itsMe,
      'es_valoracion': instance.itsReview,
      'valoracion': instance.review
    };
