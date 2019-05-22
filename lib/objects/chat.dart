/*
 * FICHERO:     chat.dart
 * DESCRIPCIÓN: clase chatMessage
 * CREACIÓN:    13/05/2019
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/message.dart';

part 'chat.g.dart';

/*
  CLASE:        Chat
  DESCRIPCIÓN:  clase objeto que recoge todos los datos asociados a una conversación
                de chat
 */

@JsonSerializable()
class Chat {
  @JsonKey(name: 'pk')
  int uid;
  @JsonKey(name: 'comprador')
  User buyer;
  @JsonKey(name: 'vendedor')
  User seller;
  @JsonKey(name: 'producto')
  Product product;
  @JsonKey(name: 'num_pendientes')
  int pendingMessages;
  @JsonKey(name: 'ultimo_mensaje', nullable: true)
  Message lastMessage;
  bool imBuyer;

  Chat(this.uid, this.buyer, this.seller, this.product, this.pendingMessages);

  Product get getProduct => product;
  Message get getLastMessage => lastMessage;
  int get numberOfPending => pendingMessages;
  bool get checkImBuyer => imBuyer;
  User get getMe => imBuyer ? buyer : seller;
  User get getOtherUser => imBuyer ? seller : buyer;
  int get getUID => uid;

  void setLastMessage(Message newLast) {
    this.lastMessage = newLast;
  }

  void setPendingMessages(int value) {
    this.pendingMessages = value;
  }

  void setImBuyer(bool value) {
    this.imBuyer = value;
  }

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);
  Map<String, dynamic> toJson() => _$ChatToJson(this);
}
