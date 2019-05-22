/*
 * FICHERO:     main_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación principal
 * CREACIÓN:    13/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/chat.dart';
import 'package:bookalo/pages/user_profile.dart';



/*
 * CLASE:        MainNavbar.dart
 * DESCRIPCIÓN: widget de la barra de navegación principal que contiene el logo de la aplicación,
 *               la opción de chat,la foto de usuario
 */

class MainNavbar extends StatelessWidget {
  MainNavbar();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height / 60;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height / 5),
          child: AppBar(
              actions: <Widget>[
                Container(
                  margin: EdgeInsets.only(top: topMargin, right: width / 30),
                  child: IconButton(
                      icon: Icon(Icons.chat_bubble_outline,
                          color: Colors.white, size: 35.0),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Chat()),
                        );
                      }),
                ),
                GestureDetector(
                    child: Container(
                        margin:
                            EdgeInsets.only(top: topMargin, right: width / 30),
                        child: Hero(
                          tag: "profileImage",
                          child: CircleAvatar(
                              backgroundImage:
                                  AssetImage('assets/images/user_picture.jpg')),
                        )),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                UserProfile(isOwnProfile: true)),
                      );
                    })
              ],
              elevation: 0.0,
              bottom: TabBar(
                indicatorWeight: 3.0,
                labelStyle:
                    TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
                indicator: BoxDecoration(color: Theme.of(context).canvasColor),
                tabs: [
                  Tab(text: Translations.of(context).text('buy_tab')),
                  Tab(text: Translations.of(context).text('sell_tab'))
                ],
                labelColor: Colors.black,
                unselectedLabelColor: Colors.white,
              ),
              title: Container(
                margin: EdgeInsets.only(top: topMargin),
                child: Image.asset('assets/images/bookalo_logo.png',
                    width: width / 2),
              )),
        ),
      ),
    );
  }
}
