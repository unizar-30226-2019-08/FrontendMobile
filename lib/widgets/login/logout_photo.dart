/*
 * FICHERO:     logout_photo.dart
 * DESCRIPCIÓN: clases relativas al widget de salida de la sesión
 * CREACIÓN:    09/04/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/utils/auth_utils.dart';

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
            await signOut();
            Navigator.of(context).pushNamedAndRemoveUntil(
                '/login', (Route<dynamic> route) => false);
          },
        ),
      ],
    );
  }
}
