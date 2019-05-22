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
  SimpleNavbar({Key key, this.preferredSize, this.title, this.iconData}) : super(key: key);

  @override
  final Size preferredSize;
  final String title;
  final IconData iconData;

  @override
  _SimpleNavbarState createState() => _SimpleNavbarState();
}

class _SimpleNavbarState extends State<SimpleNavbar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          margin: EdgeInsets.only(top: 5.0, left: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 10, top: 2),
                child: Icon(widget.iconData, size: 40.0)
              ),
              Text(
                widget.title,
                style: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w300),
              ),
            ],
          ),
        ));
  }
}
