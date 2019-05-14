/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:flutter_rating/flutter_rating.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/report.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:image_picker/image_picker.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'dart:io';


/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class CrearFoto extends StatefulWidget {
  CrearFoto();
  _CrearFotoState createState() => _CrearFotoState();
//Subir fotos de cámara
 
}




class _CrearFotoState extends State<CrearFoto>{
  File _image;

  


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

Future cameraPicker() async{
 File img= await ImagePicker.pickImage(source:ImageSource.camera);
 
setState(() {_image=img;});
}

//Subir fotos de galeria
 Future galleryPicker() async{
  File img= await ImagePicker.pickImage(source:ImageSource.gallery);
   setState(() {_image=img;});
}



   return  Row(children:[
              Column(

              children:[
                  this._image==null ?
                  Text("No hay foto"):
                  Image.file(this._image),
                Row(
                  children:[
                FloatingActionButton(
                
                onPressed:cameraPicker,
                child:Icon(Icons.add_a_photo)
              ),

              Container(width: 50.0),

              FloatingActionButton(
                onPressed: galleryPicker,
                child:Icon(Icons.image)
              ),
                  ]
                ),
              ]
              ),
              ],
              );
          

        
   
  }
  

}
