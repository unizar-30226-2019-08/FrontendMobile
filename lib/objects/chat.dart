/*
 * FICHERO:     chat.dart
 * DESCRIPCIÓN: clase chatMessage
 * CREACIÓN:    13/05/2019
 */

import 'package:json_annotation/json_annotation.dart';

part 'chat.g.dart';

/*
  CLASE: Chat
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un mensaje de chat
 */

@JsonSerializable()
class Chat {
  @JsonKey(name: 'texto')  //contenido del mensaje
  String body;
  @JsonKey(name: 'hora')  //hora de envío del mensaje
  DateTime timestamp;
  @JsonKey(name: 'es_suyo') //indica quién es el emisor del mensaje
  bool itsMe;

  Chat(this.body, this.timestamp, this.itsMe);
  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
