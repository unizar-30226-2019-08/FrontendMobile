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
import 'package:image_picker/image_picker.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'package:bookalo/widgets/add_image.dart';
import 'dart:io';


/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ListImageCard extends StatefulWidget {
   //usuario actual
  
  ListImageCard();

  _ListImageCardState createState() => _ListImageCardState();
}

class _ListImageCardState extends State<ListImageCard> {
   List <Widget> imageCards=[];
     List <File> imagesList;
  _ListImageCardState();
  File imageToAdd;

//Estado inicial de la lista
void initState() {
super.initState();
Widget card=AddImageCard(onNewPicture);
imageCards.add(card);


}
//Quitar foto de la lista
void removeFromList(File img,Widget imageCard){
  setState(() {
    
  //imageCards.remove(imageCard);
  imagesList.remove(img);
  });
}


//Añadir foto a la lista
 void onNewPicture(File img) async{
  setState(() {
    imageCards.add(ImageCard(img,removeFromList));
    imagesList.add(img);
  print("Anyadiendo a lista");

  });
 
 
}



 

  @override
  Widget build(BuildContext context) {
     double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
       width:width,
      height:height,
      child:ListView.builder(
        
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.all(10),
        itemCount: imageCards.length,
        itemBuilder:(BuildContext context,int index){
          return  imageCards[index];
        }
    ),  
         // child: Image.file(widget.image)
            
    );   
  }


//Mostrar imágenes de la lista
Widget showImage(int index){
  return new Container(
    padding:EdgeInsets.all(5.0),
    child:
      
          imageCards[index],
      
  );
}
  

  
}
