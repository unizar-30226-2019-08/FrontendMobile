/*
 * FICHERO:     add_image.dart
 * DESCRIPCIÓN: clases relativas al widget ImageAdder
 * CREACIÓN:    15/05/2019
 */

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookalo/translations.dart';
import 'dart:io';

/*
  CLASE:       ImageAdder
  DESCRIPCIÓN: widget para subida de imágenes tanto desde galería como cámara
 */

class ImageAdder extends StatefulWidget {
  final Function(File) onNewPicture;
  ImageAdder(this.onNewPicture);
  _ImageAdderState createState() => _ImageAdderState();
}

class _ImageAdderState extends State<ImageAdder> {
  File imageToAdd;

  Future pickFromCamera() async {
    File img = await ImagePicker.pickImage(source: ImageSource.camera);
    if (img != null) {
      setState(() => imageToAdd = img);
      widget.onNewPicture(imageToAdd);
    }
  }

  Future pickFromGallery() async {
    File img = await ImagePicker.pickImage(source: ImageSource.gallery);
    if (img != null) {
      setState(() => imageToAdd = img);
      widget.onNewPicture(imageToAdd);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(height: 5.0),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          OutlineButton(
            borderSide: BorderSide(color: Colors.pink, width: 3.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.add_a_photo, color: Colors.pink, size: 30.0),
                Container(width: 5.0),
                Text(
                  Translations.of(context).text("camera"),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.pink,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            onPressed: pickFromCamera,
          ),
          Container(width: 50.0),
          OutlineButton(
            borderSide: BorderSide(color: Colors.pink, width: 3.0),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.image, color: Colors.pink, size: 30.0),
                Container(width: 5.0),
                Text(
                  Translations.of(context).text("gallery"),
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.pink,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
            onPressed: pickFromGallery,
          ),
        ]),
        Divider()
      ],
    );
  }
}
