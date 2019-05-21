/*
 * FICHERO:     message.dart
 * DESCRIPCIÓN: clase chatMessage
 * CREACIÓN:    13/05/2019
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:bookalo/objects/review.dart';

part 'message.g.dart';

/*
  CLASE: Message
  DESCRIPCIÓN: clase objeto que recoge todos los datos asociados a un mensaje de chat
 */

@JsonSerializable()
class Message {
  @JsonKey(name: 'texto')
  String body;
  @JsonKey(name: 'hora')
  DateTime timestamp;
  @JsonKey(name: 'es_suyo')
  bool itsMe;
  @JsonKey(name: 'es_valoracion')
  bool itsReview;
  @JsonKey(name: 'valoracion', nullable: true)
  Review review;

  Message(this.body, this.timestamp, this.itsMe, this.itsReview, this.review);

  DateTime get getTimestamp => timestamp.toLocal();

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);
}
