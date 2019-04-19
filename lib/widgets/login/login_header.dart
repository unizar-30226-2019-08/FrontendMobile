/*
 * FICHERO:     login_header.dart
 * DESCRIPCIÓN: clases relativas al widget principal de la pantalla de inicio
 * CREACIÓN:    09/04/2019
 */

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        LoginHeader
 *  DESCRIPCIÓN:  widget principal de la pantalla de inicio. Muestra un vídeo
 *                decorativo de fondo y un texto de bienvenida
 */
class LoginHeader extends StatefulWidget {
  @override
  _LoginHeaderState createState() => _LoginHeaderState();
}

class _LoginHeaderState extends State<LoginHeader> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/intro.webm')
      ..initialize().then((_) {
        setState(() {});
      });
    _controller.setLooping(true);
    _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Stack(
        children: <Widget>[
          VideoPlayer(_controller),
          BackdropFilter(
            filter: new ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
            child: new Container(
              width: double.infinity,
              height: double.infinity,
              decoration:
                  new BoxDecoration(color: Colors.pink.withOpacity(0.6)),
            ),
          ),
          Column(
            children: <Widget>[
              Container(height: height / 10),
              Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Translations.of(context).text("welcome"),
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 90.0,
                          fontWeight: FontWeight.w300),
                    ),
                    Container(width: width / 20),
                    Container(
                      height: height / 5,
                      child: Image(
                          image: AssetImage(
                              'assets/images/bookalo_solo_logo.png')),
                    )
                  ]),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 30.0),
                child: Text(
                  Translations.of(context).text("welcome_text"),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 30.0,
                      fontWeight: FontWeight.w300),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
