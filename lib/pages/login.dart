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
import 'package:bookalo/pages/buy_and_sell.dart';
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
  var _scaffoldKey = new GlobalKey<ScaffoldState>();

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
              callback: (){},
              color: Colors.blue[900],
            ),
            LoginButton(
              inProgress: googleLoginInProgress,
              iconData: MdiIcons.google,
              callback: (){_signInWithGoogle();},
              color: Colors.red[700],
            ),
            LoginButton(
              inProgress: twitterLoginInProgress,
              iconData: MdiIcons.twitter,
              callback: (){},
              color: Colors.blue,
            )            
          ],
        ));
  }

  void _signInWithGoogle() async {
    if(!(googleLoginInProgress || facebookLoginInProgress || twitterLoginInProgress)){  
      setState(() {
        googleLoginInProgress = true;
      });
      try {
        final FirebaseAuth _auth = FirebaseAuth.instance;
        final GoogleSignIn _googleSignIn = GoogleSignIn();
        final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.getCredential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );        
        
        final FirebaseUser user = await _auth.signInWithCredential(credential);
        // assert(user.email != null);
        // assert(user.displayName != null);
        // assert(!user.isAnonymous);
        // assert(await user.getIdToken() != null);

        // final FirebaseUser currentUser = await _auth.currentUser();
        
        // assert(user.uid == currentUser.uid);
        // setState(() {
        //   googleLoginInProgress = false;
        // });
        // if (user != null) {
        //   print('HOOOOOOOOOOOOOOOOOOLA');
        //   Navigator.pushReplacementNamed(context, '/');
        // } else {
        //   _handleError("Google");
        // }
      } catch (e) {
        _handleError("Google");
      }
    }
  }

  void _handleError(String platform){
    setState(() {
      googleLoginInProgress = false;
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
