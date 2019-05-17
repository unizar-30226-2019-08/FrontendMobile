/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'dart:io';

/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ImageCard extends StatelessWidget {
  final File image; //usuario actual
  final Function(File) removePicture;
  ImageCard(
      this.image, this.removePicture); //(this.erasePicture);//({this.image});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    //Eliminar producto al pulsar la X
    onXpressed() {
      AlertDialog removeWarning = AlertDialog(
          title: Text(Translations.of(context).text("Warning")),
          content: Text(Translations.of(context).text("confirmation_text")),
          actions: [
            new FlatButton(
                onPressed: () {
                  removePicture(this.image);
                  Navigator.pop(context);
                },
                child: Text(Translations.of(context).text("Continue"))),
            new FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  Translations.of(context).text("Cancel"),
                )),
          ]);
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return removeWarning;
          });
      // erasePicture();
    }

    return Column(children: [
      Container(
        width: width / 1.5,
        height: height / 2,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            color: Colors.grey,
            child: InkWell(
                highlightColor: Colors.grey,
                splashColor: Colors.grey,
                child: Image.file(this.image)),
          ),
        ),
      ),
      IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            onXpressed();
          }) //{showDialog(context: context,builder: (BuildContext context){return removeWarning;});})
    ]);
  }
}
