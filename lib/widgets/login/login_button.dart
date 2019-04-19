/*
 * FICHERO:     login_button.dart
 * DESCRIPCIÓN: clases relativas al widget del botón de login social
 * CREACIÓN:    09/04/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

/*
 *  CLASE:        LoginButton
 *  DESCRIPCIÓN:  widget para ofrecer distantas opciones de login social en la
 *                página de inicio
 */
class LoginButton extends StatelessWidget {
  final bool inProgress;
  final IconData iconData;
  final Function callback;
  final Color color;

  /*
   * Pre:   inProgress deberá ser true si el login está en curso, iconData representa
   *        el icono del proveedor social, callback es na función void que se ejecuatará
   *        al ser pulsado si no está en progreso y color es el color del botón
   * Post:  ha devuelto un widget construido
   */ 
  LoginButton(
      {Key key, this.inProgress, this.iconData, this.callback, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GestureDetector(
        child: Container(
          height: height / 9,
          color: color,
          child: Center(
              child: (!inProgress
                  ? Icon(
                      iconData,
                      color: Colors.white,
                      size: 40.0,
                    )
                  : BookaloProgressIndicator(color: Colors.white))),
        ),
        onTap: callback);
  }
}
