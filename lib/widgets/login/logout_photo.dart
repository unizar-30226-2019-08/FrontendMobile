/*
 * FICHERO:     logout_photo.dart
 * DESCRIPCIÓN: clases relativas al widget de salida de la sesión
 * CREACIÓN:    09/04/2019
 */

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

/*
 *  CLASE:        LogoutPhoto
 *  DESCRIPCIÓN:  widget que muestra la foto de perfil del usuario y ofrece
 *                además un botón para cerrar la sesión en una esquina
 */
class LogoutPhoto extends StatelessWidget {
  final String url;

  /*
   * Pre:   url es un enlace directo a la foto de perfil del usuario
   * Post:  ha devuelto el widget construido
   */
  LogoutPhoto({Key key, this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomLeft,
      children: <Widget>[
        CircleAvatar(
          backgroundImage: NetworkImage(this.url),
          radius: 50.0,
        ),
        GestureDetector(
          child: Icon(
            Icons.remove_circle,
            color: Colors.white,
            size: 35.0,
          ),
          onTap: () async {
            String provider = "";
            await FirebaseAuth.instance.currentUser().then((user) {
              provider = user.providerData[1].providerId;
            });
            switch (provider) {
              case "google.com":
                final GoogleSignIn g = GoogleSignIn();
                await g.disconnect();
                break;
              case "twitter.com":
                var twitterLogin = TwitterLogin(
                  consumerKey: '7GfNxhqmPRol06FtTbprVA0Nk',
                  consumerSecret:
                      'cDVemq5RmvHxt1oqhX2Qg0fPTrYDPjjziwZxbbtBTiSnQw5ne8',
                );
                await twitterLogin.logOut();
                break;
              case "facebook.com":
                final facebookLogin = FacebookLogin();
                await facebookLogin.logOut();
                break;
            }
            FirebaseAuth.instance.signOut();
            Navigator.of(context)
                .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}
