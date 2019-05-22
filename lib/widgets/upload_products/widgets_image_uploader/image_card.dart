/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
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

    return Column(children: [
      Container(
        width: width / 2,
        height: height / 2,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Card(
              color: Colors.grey,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: FileImage(this.image),
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                  ),
                ),
              )),
        ),
      ),
      IconButton(
          icon: Icon(Icons.cancel), onPressed: () => removePicture(this.image))
    ]);
  }
}
