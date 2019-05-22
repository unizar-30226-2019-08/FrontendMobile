/*
 * FICHERO:     add_image.dart
 * DESCRIPCIÓN: clase que permite subir una nueva foto
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

/*
  CLASE: AddImageCard
  DESCRIPCIÓN: widget de inserción de nueva foto en una lista de fotos
 */

class AddImageCard extends StatefulWidget {
  final Function(File) onNewPicture;
  AddImageCard(this.onNewPicture);
  _AddImageCardState createState() => _AddImageCardState();


}

class _AddImageCardState extends State<AddImageCard>{
  bool state=false;
  File imageToAdd;
  bool isSelected(){
    return state;
  }


  //Cambiar estado
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

  
  //Subir fotos de cámara
    cameraPicker() async {
      File img = await ImagePicker.pickImage(source: ImageSource.camera);
      widget.onNewPicture(img);
    }

//Subir fotos de galería
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
