/*
 * FICHERO:     report_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación de la pantalla de reporte
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        ReportNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación de reporte, en el que se muestra el nombre
 *                del usuario al que se reporta
 */
class ReportNavbar extends StatefulWidget implements PreferredSizeWidget {
  /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación
     * Post:  ha construido el widget
     */
  ReportNavbar({Key key, this.preferredSize}) : super(key: key);

  @override
  final Size preferredSize;

  @override
  _ReportNavbarState createState() => _ReportNavbarState();
}

class _ReportNavbarState extends State<ReportNavbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 40;
    return AppBar(
      centerTitle: true,
      leading: Container(
          margin: EdgeInsets.only(top: topMargin / 3, right: width / 20),
          child: Icon(Icons.flag, size: 50.0)),
      title: Text(Translations.of(context).text("report_to")),
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

