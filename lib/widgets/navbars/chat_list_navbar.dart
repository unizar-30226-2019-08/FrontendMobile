/*
 * FICHERO:     chat_list_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              de las pestañas de compra/venta
 * CREACIÓN:    20/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/user_profile.dart';

/*
 *  CLASE:        ChatListNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación entre chats de Bookalo.
 *                Incluye dos pestañas (para chats de compra y venta), así cómo
 *                avatar clickable del usuario que ha iniciado sesión
 *         
 */
class ChatListNavbar extends StatefulWidget implements PreferredSizeWidget {
  /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación
     * Post:  ha construido el widget
     */
  ChatListNavbar({
    Key key,
    this.preferredSize,
  }) : super(key: key);

  @override
  final Size preferredSize;

  @override
  _ChatListNavbarState createState() => _ChatListNavbarState();
}

class _ChatListNavbarState extends State<ChatListNavbar> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return PreferredSize(
      preferredSize: Size.fromHeight(height / 7),
      child: AppBar(
          automaticallyImplyLeading: false,
          //leading: Icon(Icons.chat_bubble_outline, size: 35.0),
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            tabs: [
              Tab(text: Translations.of(context).text('buy_chat')),
              Tab(text: Translations.of(context).text('sell_chat'))
            ],
          ),
          title: Container(
            margin: EdgeInsets.only(top: 5.0, left: 10.0),
            child: Text(
              'Chats',
              style: TextStyle(fontSize: 50.0, fontWeight: FontWeight.w300),
            ),
          )),
    );
  }
}
