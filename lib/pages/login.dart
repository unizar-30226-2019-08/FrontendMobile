/*
 * FICHERO:     login_screen.dart
 * DESCRIPCIÓN: pantalla de login
 * CREACIÓN:    5/04/2019
 */

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:bookalo/widgets/login/login_header.dart';
import 'package:bookalo/widgets/login/login_button.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/auth_utils.dart';

/*
 *  CLASE:        Login
 *  DESCRIPCIÓN:  pantalla de inicio de sesión
 */

class Login extends StatefulWidget {
  Login();

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, bool> loginInProgress = {
    'Google': false,
    'Twitter': false,
    'Facebook': false
  };

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
              inProgress: loginInProgress['Facebook'],
              iconData: MdiIcons.facebook,
              callback: () {
                _signIn('Facebook');
              },
              color: Colors.blue[900],
            ),
            LoginButton(
              inProgress: loginInProgress['Google'],
              iconData: MdiIcons.google,
              callback: () {
                _signIn('Google');
              },
              color: Colors.red[700],
            ),
            LoginButton(
                inProgress: loginInProgress['Twitter'],
                iconData: MdiIcons.twitter,
                callback: () {
                  _signIn('Twitter');
                },
                color: Colors.blue)
          ],
        ));
  }

  /*
   * Pre:   ---
   * Post:  ha iniciado el proceso de inicio de sesión con el proveedor indicado
   */
  void _signIn(String provider) async {
    if (!loginInProgress.containsValue(true)) {
      setState(() {
        loginInProgress[provider] = true;
      });
      try {
        await signInFirebase(provider);
        LoginResult result = await completeLogin();
        switch (result) {
          case LoginResult.completed:
            Navigator.pushReplacementNamed(context, '/buy_and_sell');
            break;
          case LoginResult.first_time:
            //TODO: mostrar algún tipo de bienvenida
            Navigator.pushReplacementNamed(context, '/buy_and_sell');
            break;
          default:
            _handleError(provider, result);
        }
      } catch (e) {
        _handleError(provider, LoginResult.firebase_errored);
      }
    }
  }

  /*
   * Pre:   platform es la plataforma que ha causado el error
   * Post:  ha cancelado el proceso de inicio de sesión y ha informado
   *        al usuario de la incidencia
   */
  void _handleError(String provider, LoginResult result) async {
    setState(() {
      loginInProgress.updateAll((k, v) {
        return false;
      });
    });
    try {
      if (await FirebaseAuth.instance.currentUser() != null) {
        signOut();
      }
    } catch (e) {}
    _scaffoldKey.currentState.showSnackBar(SnackBar(
      content: Text(
        Translations.of(context).text("login_error",
            params: [provider, (result.index * 100).toString()]),
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
