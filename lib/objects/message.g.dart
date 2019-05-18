// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) {
  return Message(
      json['texto'] as String,
      json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
      json['es_suyo'] as bool);
}

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'texto': instance.body,
      'timestamp': instance.timestamp?.toIso8601String(),
      'es_suyo': instance.itsMe
    };
