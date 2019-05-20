/*
 * FICHERO:     simple_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación simple
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';

/*
 *  CLASE:        SimpleNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación simple, mostrando únicamente
 *                el logo de Bookalo y el avatar clickable del usuario
 */
class SimpleNavbar extends StatefulWidget implements PreferredSizeWidget {
  /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación
     * Post:  ha construido el widget
     */
  SimpleNavbar({Key key, this.preferredSize}) : super(key: key);

  @override
  final Size preferredSize;

  @override
  _SimpleNavbarState createState() => _SimpleNavbarState();
}

class _SimpleNavbarState extends State<SimpleNavbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 60;
    return AppBar(
      automaticallyImplyLeading: false,
   //   elevation: 0.0,
      title: Container(
        margin: EdgeInsets.only(top: topMargin),
        child: Image.asset('assets/images/bookalo_logo.png', width: width / 2),
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(top: topMargin, right: width / 30),
          child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_picture.jpg')),
        )
      ],
    );
  }
}
