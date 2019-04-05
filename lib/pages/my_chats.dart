/*
 * FICHERO:     MyChats.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/widgets/bubble_chat.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:bookalo/widgets/valoration_card.dart';

/*
 *  CLASE:        MyChats
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de filtrado.
 *                Consiste en dos listas diferenciadas de chats con compradores
 *                y vendedores.
 *                TEMPORALMENTE CONTIENE NAVBAR DE CHAT CONCRETO. NO SERÁ ASÍ.
 */
class MyChats extends StatefulWidget {
  MyChats();

  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    User user = User("Juan ", "https://placeimg.com/480/480/any");
    return Scaffold(
      appBar: ChatNavbar(
          preferredSize: Size.fromHeight(height / 10), interest: Interest.buys),
      body: ListView(
        children: <Widget>[
          Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: true,
            isMe: false,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: true,
            isMe: true,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: false,
            isMe: false,
          ),
          ValorationCard(
            userToValorate: user,
            currentUser: user,
          )
        ],
      ),
    );
  }
}
