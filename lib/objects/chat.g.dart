// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
      json['texto'] as String,
      json['hora'] == null ? null : DateTime.parse(json['hora'] as String),
      json['es_suyo'] as bool);
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'texto': instance.body,
      'hora': instance.timestamp?.toIso8601String(),
      'es_suyo': instance.itsMe
    };
