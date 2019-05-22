/*
 * FICHERO:     chat.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/valoration_card.dart';
import 'package:bookalo/translations.dart';

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
  bool closed = false;

  void setClosed(BuildContext context) => setState(() => closed = true);

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ChatNavbar(
        preferredSize: Size.fromHeight(height / 10),
        interest: widget.interest,
        user: widget.user,
        product: widget.product,
      ),
      body: ListView(children: <Widget>[
        OutlineButton(
          borderSide: BorderSide(color: Colors.pink, width: 3.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Text(
            Translations.of(context).text("close_chat"),
            style:
                TextStyle(color: Colors.pink[600], fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            //comprobar si la información introducida es válida al pulsar
            setClosed(context);
          },
        ),
        closed == false
            ? Container(height: 30)
            : ValorationCard(
                userToValorate: widget.user, currentUser: widget.user),
        Container(height: 50.0),
        Padding(
            padding: const EdgeInsets.only(bottom: 30.0),
            child: Container(
              margin: EdgeInsets.only(bottom: 1.0),
              child: TextFormField(
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0)),
                    suffixIcon:
                        IconButton(icon: Icon(Icons.send), onPressed: null)),
                keyboardType: TextInputType.text,
                maxLines: null,
              ),

              // IconButton(icon:Icon(Icons.send,size:50.0), onPressed:null )
            ))
      ]),
    );
  }
}
