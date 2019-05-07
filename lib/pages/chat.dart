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
import 'package:bookalo/utils/objects_generator.dart';

/*
 *  CLASE:        Chat
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de un chat concreto
 */
class Chat extends StatefulWidget {
  Chat();

  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    User user = generateRandomUser();
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
