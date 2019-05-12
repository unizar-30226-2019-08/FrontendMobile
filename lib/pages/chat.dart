/*
 * FICHERO:     MyChats.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/bubble_chat.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:bookalo/widgets/valoration_card.dart';

/*
 *  CLASE:        Chat
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de un chat concreto
 */
class Chat extends StatefulWidget {
  final User user;
  final Product product;
  final Interest interest;

  Chat({Key key, this.user, this.product, this.interest}) : super(key: key);


  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ChatNavbar(
          preferredSize: Size.fromHeight(height / 10), interest: widget.interest, user: widget.user, product: widget.product,),
      body: ListView(
        children: <Widget>[
          Bubble(
            message: lipsum.createSentence(),
            user: widget.user,
            time: DateTime.now(),
            sent: true,
            isMe: false,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: widget.user,
            time: DateTime.now(),
            sent: true,
            isMe: true,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: widget.user,
            time: DateTime.now(),
            sent: false,
            isMe: false,
          ),
          ValorationCard(
            userToValorate: widget.user,
            currentUser: widget.user,
          )
        ],
      ),
    );
  }
}
