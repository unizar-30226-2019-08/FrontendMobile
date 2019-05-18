/*
 * FICHERO:     upload_images.dart
 * DESCRIPCIÓN: clases relativas a la subida de imagens para subir producto
 * CREACIÓN:    12/05/2019
 */

import 'dart:io';

import 'package:bookalo/widgets/upload_products/widgets_image_uploader/list_image.dart';
import 'package:flutter/material.dart';

/*
 *  CLASE:        UploadImages
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadImages extends StatefulWidget {
	final Function(bool) validate;
	final List<File> imagesList;
	UploadImages({Key key, this.imagesList, this.validate}) : super(key: key);

	@override
	_UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
	@override
	Widget build(BuildContext context) {
		List<Widget> imageCard = [];
		return Container(
			child: ListImageCard(
				imageCards: imageCard,
				imagesList: widget.imagesList,
				validate: (val) {
					widget.validate(val);
				},
			),
		);
	}
}

