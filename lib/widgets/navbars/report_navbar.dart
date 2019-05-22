/*
 * FICHERO:     simple_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación simple
 * CREACIÓN:    12/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        SimpleNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación simple, mostrando únicamente
 *                el logo de Bookalo y el avatar clickable del usuario
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
/* Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 60;
    return Pre(
      automaticallyImplyLeading: false,
      leading: Container(
            margin: EdgeInsets.only(top: topMargin * 0.7, right: width / 30),
        child: Icon(Icons.flag)
      ),
      title: Text("Report a "),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(top: topMargin, right: width / 30),
          child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user_picture.jpg')),
        )
      ],
    );
  }
}*/
