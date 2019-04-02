/*
 * FICHERO:     user_profile.dart
 * DESCRIPCIÓN: clases relativas al la página personal de un usuario
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/profile_navbar.dart';

/*
 *  CLASE:        UserProfile
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de perfiles
 *                de usuario. Contiene información del usuario (en la navbar)
 *                y dos pestañas: una para productos en venta y otra para opiniones
 */
class UserProfile extends StatefulWidget {

  UserProfile();

  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: ProfileNavbar(preferredSize: Size.fromHeight(height/3.3)),
        body: TabBarView(
          children: [
            Scaffold(),
            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}