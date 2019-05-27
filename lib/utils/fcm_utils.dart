/*
 * FICHERO:     fcm_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de mensajes FCM
 * CREACIÓN:    17/05/2019
 */
import 'dart:convert';
import 'package:bookalo/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/objects/message.dart';

void handleChatMessage(Map<String, dynamic> message, BuildContext context,
    GlobalKey navigatorKey) async {
  ChatsRegistry registry = ScopedModel.of<ChatsRegistry>(context);
  try {
    Chat chat = Chat.fromJson(jsonDecode(message['data']['chat']));
    chat.setImBuyer(message['data']['soy_vendedor'] == 'false');
    registry.addChats(
        message['data']['soy_vendedor'] == 'true' ? 'buyers' : 'sellers',
        [chat]);
    print('NOTIFICACION:' + message.toString());
    if ((message['notification'] as Map).values.length > 0 && message['notification']['title'] == null) {
      print("TIPO 1");
      Message newMessage =
          Message.fromJson(jsonDecode(message['data']['mensaje']));
      registry.addMessage(
          message['data']['soy_vendedor'] == 'false' ? 'sellers' : 'buyers',
          chat,
          newMessage);
    } else {
      print("TIPO 2");
      Chat chat = Chat.fromJson(jsonDecode(message['data']['chat']));
      chat.setImBuyer(message['data']['soy_vendedor'] == 'false');
      Navigator.push(navigatorKey.currentContext,
          MaterialPageRoute(builder: (_) => ChatPage(chat: chat)));
    }
  } catch (e) {
    print(e);
  }
}