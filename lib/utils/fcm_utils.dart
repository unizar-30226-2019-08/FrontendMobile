/*
 * FICHERO:     fcm_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de mensajes FCM
 * CREACIÓN:    17/05/2019
 */
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/pages/chat_page.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/objects/message.dart';

void handleChatMessage(Map<String, dynamic> message, BuildContext context) {
  ChatsRegistry registry = ScopedModel.of<ChatsRegistry>(context);
  try {
    Chat chat = Chat.fromJson(jsonDecode(message['data']['chat']));
    chat.setImBuyer(message['data']['soy_vendedor'] == 'true');
    
    Message newMessage =
        Message.fromJson(jsonDecode(message['data']['mensaje']));
    registry.addMessage(
        message['data']['soy_vendedor'] == 'true' ? 'sellers' : 'buyers',
        chat,
        newMessage);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ChatPage(chat: chat)),
    );
  } catch (e) {
    print(e);
  }
}
