/*
 * FICHERO:     chat_list_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              de las pestañas de compra/venta
 * CREACIÓN:    20/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/chats_menu.dart';
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
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 40;
    return PreferredSize(
      preferredSize: Size.fromHeight(height / 5),
      child: AppBar(
          actions: <Widget>[
          
            GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(top: topMargin, right: width / 30),
                    child: Hero(
                      tag: "profileImage",
                      child: CircleAvatar(
                          backgroundImage:
                              AssetImage('assets/images/user_picture.jpg')),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserProfile()),
                  );
                })
          ],
          elevation: 0.0,
          bottom: TabBar(
            indicatorWeight: 3.0,
            labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            indicator: BoxDecoration(color: Theme.of(context).canvasColor),
            tabs: [
              Tab(text: Translations.of(context).text('buyChat_tab')), //pestañas de navegacion
              Tab(text: Translations.of(context).text('sellChat_tab'))
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
          ),
          title: Container(
            margin: EdgeInsets.only(top: topMargin),
            child:
                Image.asset('assets/images/bookalo_logo.png', width: width / 2),
          )),
    );
  }
}
