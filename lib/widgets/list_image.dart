/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'package:flutter/material.dart';
import 'package:bookalo/widgets/image_card.dart';
import 'package:bookalo/widgets/add_image.dart';
import 'dart:io';

/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ListImageCard extends StatefulWidget {
  //usuario actual
  final Function validate;
  final List<Widget> imageCards;
  final List<File> imagesList;
  ListImageCard({Key key, this.imagesList, this.imageCards, this.validate}) : super(key: key);

  _ListImageCardState createState() => _ListImageCardState();
}

class _ListImageCardState extends State<ListImageCard> {

  _ListImageCardState();
  File imageToAdd;

//Estado inicial de la lista
  void initState() {
    super.initState();
    Widget card = AddImageCard(onNewPicture);
    widget.imageCards.add(card);
    widget.imagesList.forEach((image){
      ImageCard imgC = ImageCard(image, removeFromList);
      widget.imageCards.add(imgC);
    });
  }

//Quitar foto de la lista
  void removeFromList(File img) {
    setState(() {
      var i = widget.imagesList.indexOf(img);
      widget.imageCards
          .removeAt(i + 1); //i+1 porque el primero es el widget de añadir fotos
      widget.imagesList.removeAt(i);
      widget.validate(widget.imagesList.length > 0);
    });
  }


//Añadir foto a la lista
  void onNewPicture(File img) async {
    setState(() {
      ImageCard imgC = ImageCard(img, removeFromList);
      widget.imageCards.add(imgC);
      widget.imagesList.add(img);
      widget.validate(widget.imagesList.length > 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      width: width,
      height: height,
      child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.all(10),
          itemCount: widget.imageCards.length,
          itemBuilder: (BuildContext context, int index) {
            return widget.imageCards[index];
          }),
      // child: Image.file(widget.image)
    );
  }

//Mostrar imágenes de la lista
  Widget showImage(int index) {
    return new Container(
      padding: EdgeInsets.all(5.0),
      child: widget.imageCards[index],
    );
  }
}
