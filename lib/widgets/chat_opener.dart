/*
 * FICHERO:     chat_opener.dart
 * DESCRIPCIÓN: clases relativas al widget ChatOpener
 * CREACIÓN:    14/05/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/pages/chat_page.dart';
import 'package:bookalo/translations.dart';

class ChatOpener extends StatefulWidget {
  final User user;
  final Product product;

  ChatOpener({Key key, this.user, this.product}) : super(key: key);

  @override
  _ChatOpenerState createState() => _ChatOpenerState();
}

class _ChatOpenerState extends State<ChatOpener> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    if(widget.product.checkfForSale()){
      if (isLoading) {
        return BookaloProgressIndicator();
      } else {
        return IconButton(
          icon: Icon(
            Icons.chat_bubble_outline,
            color: Colors.pink,
            size: 40.0,
          ),
          onPressed: () async {
            setState(() => isLoading = true);
            Chat chat = await createChat(widget.user, widget.product, context);
            setState(() => isLoading = false);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ChatPage(chat: chat)),
            );
          },
        );
      }
    }else{
      return Chip(
        label: Text(Translations.of(context).text("chat_finished"), style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.pink,
      );
    }
  }
}
