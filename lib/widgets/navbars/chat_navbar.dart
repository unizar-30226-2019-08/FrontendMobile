/*
 * FICHERO:     chat_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              del para convesaciones de chat
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/user_profile.dart';
import 'package:bookalo/utils/dates_utils.dart';

enum Interest {
  buys, offers
}

/*
 *  CLASE:        ChatNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación en conversaciones de chat.
 *                Muestra avatar clickable del interlocutor, su interés (compra/venta),
 *                momento de la última conexión y foto clickable del producto
 */
class ChatNavbar extends StatefulWidget implements PreferredSizeWidget {
    /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación. Además, interest es uno de los tipos definidos por
     *        enumeración de Interest
     * Post:  ha construido el widget
     */ 
    ChatNavbar({Key key, this.preferredSize, this.interest}) : super(key: key);

    final Interest interest;
    @override
    final Size preferredSize;

    @override
    _ChatNavbarState createState() => _ChatNavbarState();
}

class _ChatNavbarState extends State<ChatNavbar>{

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double topMargin = height/40;      
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(top: topMargin, left: width/30),
          child: GestureDetector(
            child: Hero(
              tag: "profileImage",
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_picture.jpg')
              )
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => UserProfile()),
              );
            }
          )
        ),
        title: Text(Translations.of(context).text(widget.interest.toString().split('.').last)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: topMargin, right: width/30),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/boli.jpg')
            ),
          ),
        ],
        flexibleSpace: Center(
          child: Container(
            child: Text(
              Translations.of(context).text("last_time") + ' ' + dateToFullString(DateTime.now(), context),
              style: TextStyle(color: Colors.white),),
            margin: EdgeInsets.only(top:topMargin*3),
          ),
        ),
      );
    }
}