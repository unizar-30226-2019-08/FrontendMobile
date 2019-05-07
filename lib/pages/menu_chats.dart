/*
 *  CLASE:        menuChats
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de chats abierto
 *                de un usuario. Los chats se dividen en dos listas: una para los
 *                artícullos que el usuario quiere comprar y otra para los que quiere vender
 *                
 */

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:bookalo/widgets/miniature_chat.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';
import 'package:bookalo/utils/objects_generator.dart';

class ChatsList extends StatelessWidget {
  ChatsList({Key key, this.salesChat}) : super(key: key);

  final bool salesChat; //vale true si el mensaje se ha enviado

  @override
  Widget build(BuildContext context) {
    final String lastMessage = 'hola';
    final bool closed = true;
    final DateTime lastTimeDate = DateTime.now();

    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: SimpleNavbar(
          preferredSize: Size.fromHeight(height / 10),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text("Mis compradores",
                  style: TextStyle(
                      fontWeight: FontWeight.w300, height: 1.0, fontSize: 35)),
            ),
            Container(
              height: height / 3.3,
              child: ListView(children: [
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: false,
                    lastTimeDate: lastTimeDate,
                    isBuyer: false),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: false,
                    lastTimeDate: lastTimeDate,
                    isBuyer: false),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: false,
                    lastTimeDate: lastTimeDate,
                    isBuyer: false),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: closed,
                    lastTimeDate: lastTimeDate,
                    isBuyer: false),
              ]),
            ),
            Container(height: height / 40),
            Container(
              margin: EdgeInsets.all(10.0),
              child: Text("Mis vendedores",
                  style: TextStyle(
                      fontWeight: FontWeight.w300, height: 1.0, fontSize: 35)),
            ),
            Container(
              height: height / 3.3,
              child: ListView(children: [
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: closed,
                    lastTimeDate: lastTimeDate,
                    isBuyer: true),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: closed,
                    lastTimeDate: lastTimeDate,
                    isBuyer: true),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: closed,
                    lastTimeDate: lastTimeDate,
                    isBuyer: true),
                Divider(),
                MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: lastMessage,
                    closed: closed,
                    lastTimeDate: lastTimeDate,
                    isBuyer: true),
              ]),
            ),
          ],
        ));
  }
}
