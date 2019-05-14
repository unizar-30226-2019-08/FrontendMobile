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

class AddImageCard extends StatefulWidget {
  final Function(File) onNewPicture;
  AddImageCard(this.onNewPicture);
  _AddImageCardState createState() => _AddImageCardState();
//Subir fotos de cámara
 
}




class _AddImageCardState extends State<AddImageCard>{
  bool state=false;
  File imageToAdd;
  bool isSelected(){
    return state;
  }
  void changeState(){
   if(state){
     setState(() {
       state=false;
     });
   }
   else{
     setState(() {
      state=true;
     });
   }
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

Future cameraPicker() async{
  
 File img= await ImagePicker.pickImage(source:ImageSource.camera);
 setState(() {
   imageToAdd=img;
 });
 widget.onNewPicture(imageToAdd);

}

//Subir fotos de galeria
 Future galleryPicker() async{
  File img= await ImagePicker.pickImage(source:ImageSource.gallery);
  setState(() {
   imageToAdd=img;
 });
  widget.onNewPicture(imageToAdd);
 
}



   return Column(
          children:[
               Container(
                 width:width/1.5,
                 height:height/2,
                 child:
                Padding(
        padding: EdgeInsets.all(5),
        child:Card(
          color:Colors.grey,
      child: InkWell(
        highlightColor: Colors.grey,
        splashColor: Colors.grey,
        onTap: () {
          changeState();
        },

        child:Center(child:
        Container(
          width:width/2,
           height:height/2,
           padding: EdgeInsets.symmetric(vertical: 5.0),
           child:Center(child:Icon(Icons.add_circle))
           )
           )
        ),
      ),
    ),
),
   Container(height: 50.0),
 isSelected()==true ? Row(children:[
              FloatingActionButton(
                
                onPressed:cameraPicker,
                child:Icon(Icons.add_a_photo)
              ),

              Container(width: 50.0),

              FloatingActionButton(
                onPressed: galleryPicker,
                child:Icon(Icons.image)
              ),
              ],)
              :Container(height: 50.0),
          


              ]
   );
   
  }
  

}
