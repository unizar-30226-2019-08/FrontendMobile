/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class AddImageCard extends StatefulWidget {
  final Function onNewPicture;
  AddImageCard(this.onNewPicture);
  _AddImageCardState createState() => _AddImageCardState();
//Subir fotos de cámara

}

class _AddImageCardState extends State<AddImageCard> {
  bool state = false;

  bool isSelected() {
    return state;
  }

  void changeState() {
    if (state) {
      setState(() {
        state = false;
      });
    } else {
      setState(() {
        state = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    cameraPicker() async {
      File img = await ImagePicker.pickImage(source: ImageSource.camera);
      widget.onNewPicture(img);
    }

//Subir fotos de galeria
    galleryPicker() async {
      File img = await ImagePicker.pickImage(source: ImageSource.gallery);
      widget.onNewPicture(img);
    }

    return Column(children: [
      Container(
        width: width,
        height: height / 2,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Card(
            child: InkWell(
                highlightColor: Colors.grey,
                splashColor: Colors.grey,
                onTap: () {
                  changeState();
                },
                child: Center(
                    child: Container(
                        width: 150.0,
                        height: 200.0,
                        padding: EdgeInsets.symmetric(vertical: 5.0),
                        child: Center(child: Icon(Icons.add_circle))))),
          ),
        ),
      ),
      Container(height: 50.0),
      isSelected() == true
          ? Row(
              children: [
                FloatingActionButton(
                    onPressed: cameraPicker, child: Icon(Icons.add_a_photo)),
                Container(height: 15.0),
                FloatingActionButton(
                    onPressed: galleryPicker, child: Icon(Icons.image)),
              ],
            )
          : Container(height: 50.0),
    ]);
  }
}
