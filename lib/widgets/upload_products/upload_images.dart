/*
 * FICHERO:     upload_images.dart
 * DESCRIPCIÓN: clases relativas a la subida de imagens para subir producto
 * CREACIÓN:    12/05/2019
 */

import 'dart:io';

import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/widgets/upload_products/widgets_image_uploader/list_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

/*
 *  CLASE:        UploadImages
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadImages extends StatefulWidget {
  final Function(bool) validate;
  final List<File> imagesList;
  final List<String> imagesNW;
  UploadImages({Key key, this.imagesList, this.validate, this.imagesNW})
      : super(key: key);

  @override
  _UploadImagesState createState() => _UploadImagesState();
}

class _UploadImagesState extends State<UploadImages> {
  @override
  Widget build(BuildContext context) {
    List<Widget> imageCard = [];
    return Container(
      child: (widget.imagesList != null && widget.imagesList.length < 1 && widget.imagesNW.length > 0)? 
          FutureBuilder<List<File>>(
          future: _getImagesProduct(widget.imagesNW),
          builder: (BuildContext context, AsyncSnapshot<List<File>> snapshot) {
            if (snapshot.hasData) {
              widget.imagesList.addAll(snapshot.data);
              return ListImageCard(
                imageCards: imageCard,
                imagesList: widget.imagesList,
                validate: (val) {
                  widget.validate(val);
                },
              );
            }else {
            return Center(child: BookaloProgressIndicator());
          }
          })
    : ListImageCard(
                imageCards: imageCard,
                imagesList: widget.imagesList,
                validate: (val) {
                  widget.validate(val);
                },
              )
    );
  }

  Future<List<File>> _getImagesProduct(List<String> urls) async {
    List<File> files = [];
    print("Cargando imagenes");
    for(int i = 0; i < urls.length; i++){
      var cacheManager = await CacheManager.getInstance();
      File file = await cacheManager.getFile(urls[i]);
      files.add(file);
    }
    print("numero de imagenes a cargar = " + urls.length.toString());
    print("numero de imagenes cargadas = " + files.length.toString());
    return files;
  }
}
