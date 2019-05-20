/*
 * FICHERO:     valoration_card.dart
 * DESCRIPCIÓN: clases relativas al widget de valoración de usuario al cerrar una venta
 * CREACIÓN:    20/03/2019
 */

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/upload_products/widgets_image_uploader/image_card.dart';
import 'package:bookalo/widgets/upload_products/widgets_image_uploader/add_image.dart';
import 'package:bookalo/widgets/empty_list.dart';

/*
  CLASE: ImageCard
  DESCRIPCIÓN: widget de valoración de un usuario al cerrar una venta
 */

class ListImageCard extends StatefulWidget {
  //usuario actual
  final Function validate;
  final List<Widget> imageCards;
  final List<File> imagesList;
  ListImageCard({Key key, this.imagesList, this.imageCards, this.validate})
      : super(key: key);

  _ListImageCardState createState() => _ListImageCardState();
}

class _ListImageCardState extends State<ListImageCard> {
  _ListImageCardState();
  File imageToAdd;

//Estado inicial de la lista
  void initState() {
    super.initState();
    widget.imagesList.forEach((image) {
      ImageCard imgC = ImageCard(image, removeFromList);
      widget.imageCards.add(imgC);
    });
  }

//Quitar foto de la lista
  void removeFromList(File img) {
    setState(() {
      var i = widget.imagesList.indexOf(img);
      widget.imageCards
          .removeAt(i); //i+1 porque el primero es el widget de añadir fotos
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
      child: Column(
        children: <Widget>[
          ImageAdder(onNewPicture),
          Expanded(
            child: ListView(
              children: <Widget>[
                (widget.imageCards.length > 0
                    ? Wrap(
                        children: widget.imageCards,
                      )
                    : EmptyList(iconData: Icons.image, textKey: "no_pictures"))
              ],
            ),
          ),
        ],
      ),
    );
  }
}
