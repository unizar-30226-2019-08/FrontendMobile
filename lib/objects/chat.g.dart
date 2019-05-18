// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Chat _$ChatFromJson(Map<String, dynamic> json) {
  return Chat(
      json['pk'] as int,
      json['comprador'] == null
          ? null
          : User.fromJson(json['comprador'] as Map<String, dynamic>),
      json['vendedor'] == null
          ? null
          : User.fromJson(json['vendedor'] as Map<String, dynamic>),
      json['producto'] == null
          ? null
          : Product.fromJson(json['producto'] as Map<String, dynamic>),
      json['num_pendientes'] as int)
    ..imBuyer = json['es_vendedor'] as bool;
}

Map<String, dynamic> _$ChatToJson(Chat instance) => <String, dynamic>{
      'pk': instance.uid,
      'comprador': instance.buyer,
      'vendedor': instance.seller,
      'producto': instance.product,
      'num_pendientes': instance.pendingMessages,
      'es_vendedor': instance.imBuyer
    };
