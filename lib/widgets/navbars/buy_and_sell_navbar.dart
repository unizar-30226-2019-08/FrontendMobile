/*
 * FICHERO:     buy_and_sell_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              de las pestañas de compra/venta
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/my_chats.dart';
import 'package:bookalo/pages/my_profile.dart';

/*
 *  CLASE:        BuyAndSellNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación principal de Bookalo.
 *                Incluye dos pestañas (para compra y venta), así cómo
 *                avatar clickable del usuario que ha iniciado sesión y
 *                acceso a la sección de 'Mis chats'
 */
class BuyAndSellNavbar extends StatefulWidget implements PreferredSizeWidget {
    /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación
     * Post:  ha construido el widget
     */      
    BuyAndSellNavbar({Key key, this.preferredSize, }) : super(key: key);

    @override
    final Size preferredSize;

    @override
    _BuyAndSellNavbarState createState() => _BuyAndSellNavbarState();
}

class _BuyAndSellNavbarState extends State<BuyAndSellNavbar>{

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double topMargin = height/40;      
      return PreferredSize(
        preferredSize: Size.fromHeight(height/5),
        child: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(top: topMargin, right: width/30),
              child: IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 35.0),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyChats()),
                  );
                }
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: topMargin, right: width/30),
                child: Hero(
                  tag: "profileImage",
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_picture.jpg')
                  ),
                )
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              }
            )
          ],
          elevation: 0.0,
          bottom: TabBar(
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 20.0, 
              fontWeight: FontWeight.w300),
            indicator: BoxDecoration(
              color: Theme.of(context).canvasColor
            ),
            tabs: [
              Tab(text: Translations.of(context).text('buy_tab')),
              Tab(text: Translations.of(context).text('sell_tab'))
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
          ),
          title: Container(
            margin: EdgeInsets.only(top: topMargin),
            child: Image.asset('assets/images/bookalo_logo.png', width: width/2),
          )
        ),
      );
    }
}
