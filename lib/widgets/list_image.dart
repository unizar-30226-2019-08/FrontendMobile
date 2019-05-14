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

  ListImageCard();

  _ListImageCardState createState() => _ListImageCardState();
}

class _ListImageCardState extends State<ListImageCard> {
  List<Widget> imageCards = [];
  List<File> imagesList;
  _ListImageCardState();

  void initState() {
    super.initState();
    Widget card = AddImageCard(addImageToList);
    imageCards.add(card);
  }

  void removeFromList(File img, Widget imageCard) {
    imageCards.remove(imageCard);
    imagesList.remove(img);
    setState(() {});
  }

//Subir fotos de cámara
  void addImageToList(File img) async {
    imageCards.add(ImageCard(img, removeFromList));
    imagesList.add(img);
    setState(() {});
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
          itemCount: imageCards.length,
          itemBuilder: (BuildContext context, int index) {
            //return imageCards[index];
          }),
      // child: Image.file(widget.image)
    );
  }
}
