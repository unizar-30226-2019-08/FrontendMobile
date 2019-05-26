/*
 * FICHERO:     buy_and_sell_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              de las pestañas de compra/venta
 * CREACIÓN:    13/03/2019
 */
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/chats_menu.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/pages/user_profile.dart';

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
  BuyAndSellNavbar({
    Key key,
    this.preferredSize,
  }) : super(key: key);

  @override
  final Size preferredSize;

  @override
  _BuyAndSellNavbarState createState() => _BuyAndSellNavbarState();
}

class _BuyAndSellNavbarState extends State<BuyAndSellNavbar> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 40;
    return PreferredSize(
      preferredSize: Size.fromHeight(0),
      child: AppBar(
          automaticallyImplyLeading: false,
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(top: topMargin * 0.7, right: width / 30),
              child: IconButton(
                  icon: Icon(Icons.chat,
                      color: Colors.white,
                      size: 35.0),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatMenu()),
                    );
                  }),
            ),
            GestureDetector(
                child: Container(
                    margin: EdgeInsets.only(top: topMargin, right: width / 30),
                    child: Hero(
                      tag: "ownProfileImage",
                      child: FutureBuilder<FirebaseUser>(
                          future: FirebaseAuth.instance.currentUser(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              return CircleAvatar(
                                  backgroundImage:
                                      NetworkImage(snapshot.data.photoUrl));
                            } else {
                              return CircularProgressIndicator();
                            }
                          }),
                    )),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => UserProfile(isOwnProfile: true)),
                  );
                })
          ],
          bottom: TabBar(
            labelStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
            tabs: [
              Tab(text: Translations.of(context).text('buy_tab')),
              Tab(text: Translations.of(context).text('sell_tab'))
            ],
          ),
          title: Container(
            margin: EdgeInsets.only(top: topMargin),
            child:
                Image.asset('assets/images/bookalo_logo.png', width: width / 2),
          )),
    );
  }
}
