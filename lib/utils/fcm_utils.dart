/*
 * FICHERO:     fcm_utils.dart
 * DESCRIPCIÓN: funciones para el tratamiento de mensajes FCM
 * CREACIÓN:    17/05/2019
 */
import 'dart:convert';
import 'package:bookalo/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart'
    as LN;
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/objects/message.dart';

void handleChatMessage(
    Map<String, dynamic> message,
    LN.FlutterLocalNotificationsPlugin plugin,
    BuildContext context,
    GlobalKey navigatorKey) async {
  ChatsRegistry registry = ScopedModel.of<ChatsRegistry>(context);
  try {
    Chat chat = Chat.fromJson(jsonDecode(message['data']['chat']));
    chat.setImBuyer(message['data']['soy_vendedor'] == 'false');
    registry.addChats(
        message['data']['soy_vendedor'] == 'true' ? 'buyers' : 'sellers',
        [chat]);
    if (message['notification']['title'] == null) {
      Message newMessage =
          Message.fromJson(jsonDecode(message['data']['mensaje']));
      registry.addMessage(
          message['data']['soy_vendedor'] == 'false' ? 'sellers' : 'buyers',
          chat,
          newMessage);
      if (!newMessage.itsMe) {}
    } else {
      Chat chat = Chat.fromJson(jsonDecode(message['data']['chat']));
      chat.setImBuyer(message['data']['soy_vendedor'] == 'false');
      Navigator.push(navigatorKey.currentContext,
          MaterialPageRoute(builder: (_) => ChatPage(chat: chat)));
    }
  } catch (e) {
    print(e);
  }
}

void displayNotification(
    LN.FlutterLocalNotificationsPlugin plugin, Message message, Chat chat) {
  var androidPlatformChannelSpecifics = LN.AndroidNotificationDetails(
      'es.bookalo.bookalo', 'Bookalo', 'Bookalo messaging',
      importance: LN.Importance.Max,
      priority: LN.Priority.High,
      ticker: 'ticker');
  var iOSPlatformChannelSpecifics = LN.IOSNotificationDetails();
  var platformChannelSpecifics = LN.NotificationDetails(
      androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
  plugin.show(
      0,
      chat.getOtherUser.getName() + ' (' + chat.getProduct.getName() + ')',
      message.body,
      platformChannelSpecifics,
      payload: chat.getUID.toString());
}
