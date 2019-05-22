/*
 * FICHERO:    list_image.dart
 * DESCRIPCIÓN: clases relativas a la visualización de fotos subidas
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'package:bookalo/widgets/add_image.dart';
import 'dart:io';

/*
  CLASE: ListImageCard
  DESCRIPCIÓN: widget de visualización de fotos añadidas del producto
 */

class ListImageCard extends StatefulWidget {
  

  ListImageCard();

  _ListImageCardState createState() => _ListImageCardState();
}

class _ListImageCardState extends State<ListImageCard> {
  List<Widget> imageCards = []; //lista de widgets con lo que se visualizan las imágenes 
  List<File> imagesList;//lista de imágenes guardadas
  _ListImageCardState();
  File imageToAdd; //imagen a añadir

//Estado inicial de la lista (solo widget de añadir fotos)
void initState() {
super.initState();
Widget card=AddImageCard(onNewPicture);
imageCards.add(card);


}
//Quitar foto de la lista
void removeFromList(File img) {


  setState(() {
    var i=imagesList.indexOf(img);
  imageCards.removeAt(i+1);//i+1 porque el primero es el widget de añadir fotos
  imagesList.removeAt(i);
  });


}


//Añadir foto a la lista
 void onNewPicture(File img) async{
  setState(() {
    ImageCard imgC=ImageCard(img,removeFromList);
    imageCards.add(imgC);
    imagesList.add(img);

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
