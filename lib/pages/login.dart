/*
 * FICHERO:     login_screen.dart
 * DESCRIPCIÓN: pantalla de login
 * CREACIÓN:    5/04/2019
 */

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutter_twitter_login/flutter_twitter_login.dart';
import 'package:bookalo/widgets/login/login_header.dart';
import 'package:bookalo/widgets/login/login_button.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        Login
 *  DESCRIPCIÓN:  Pantalla de inicio de sesión
 */

class Login extends StatefulWidget {
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  bool googleLoginInProgress = false;
  bool facebookLoginInProgress = false;
  bool twitterLoginInProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.blue[900],
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            LoginHeader(),
            LoginButton(
              inProgress: facebookLoginInProgress,
              iconData: MdiIcons.facebook,
              callback: () {
                _signInWithFacebook();
              },
              color: Colors.blue[900],
              key: Key("facebook_login"),
            ),
            LoginButton(
              inProgress: googleLoginInProgress,
              iconData: MdiIcons.google,
              callback: () {
                _signInWithGoogle();
              },
              color: Colors.red[700],
              key: Key("google_login"),
            ),
            LoginButton(
                inProgress: twitterLoginInProgress,
                iconData: MdiIcons.twitter,
                callback: () {
                  _signInWithTwitter();
                },
                color: Colors.blue,
                key: Key("twitter_login"))
          ],
        ));
  }

  /*
   * Pre:   ---
   * Post:  ha lanzado el proceso de inicio de sesión con Google
   */
  void _signInWithGoogle() async {
    if (!(googleLoginInProgress ||
        facebookLoginInProgress ||
        twitterLoginInProgress)) {
      setState(() {
        googleLoginInProgress = true;
      });
      try {
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        await FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        _handleError("Google");
      }
    }
  }

  /*
   * Pre:   ---
   * Post:  ha lanzado el proceso de inicio de sesión con Facebook
   */
  void _signInWithFacebook() async {
    if (!(googleLoginInProgress ||
        facebookLoginInProgress ||
        twitterLoginInProgress)) {
      setState(() {
        facebookLoginInProgress = true;
      });
      try {
        final facebookLogin = FacebookLogin();
        final result = await facebookLogin.logInWithReadPermissions(['email']);
        final AuthCredential credential = FacebookAuthProvider.getCredential(
            accessToken: result.accessToken.token);
        FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        _handleError("Facebook");
      }
    }
  }

  /*
   * Pre:   ---
   * Post:  ha lanzado el proceso de inicio de sesión con Twitter
   */
  void _signInWithTwitter() async {
    if (!(googleLoginInProgress ||
        facebookLoginInProgress ||
        twitterLoginInProgress)) {
      setState(() {
        twitterLoginInProgress = true;
      });
      try {
        var twitterLogin = TwitterLogin(
          consumerKey: '7GfNxhqmPRol06FtTbprVA0Nk',
          consumerSecret: 'cDVemq5RmvHxt1oqhX2Qg0fPTrYDPjjziwZxbbtBTiSnQw5ne8',
        );
        final TwitterLoginResult result = await twitterLogin.authorize();
        final AuthCredential credential = TwitterAuthProvider.getCredential(
            authToken: result.session.token,
            authTokenSecret: result.session.secret);
        FirebaseAuth.instance.signInWithCredential(credential);
      } catch (e) {
        _handleError("Twitter");
      }
    }
  }

  /*
   * Pre:   platform es la plataforma que ha causado el error
   * Post:  ha cancelado el proceso de inicio de sesión y ha informado
   *        al usuario de la incidencia
   */
  void _handleError(String platform) {
    setState(() {
      googleLoginInProgress = false;
      facebookLoginInProgress = false;
      twitterLoginInProgress = false;
    });
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        Translations.of(context).text("login_error", params: [platform]),
        style: TextStyle(fontSize: 17.0),
      ),
      action: SnackBarAction(
        label: Translations.of(context).text("accept"),
        onPressed: () {
          _scaffoldKey.currentState.hideCurrentSnackBar();
        },
      ),
    ));
  }
}
