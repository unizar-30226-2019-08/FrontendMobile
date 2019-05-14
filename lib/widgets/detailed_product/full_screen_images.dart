/*
 * FICHERO:     full_screen_images.dart
 * DESCRIPCIÓN: relativo al widget FullScreenImage
 * CREACIÓN:    25/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/detailed_product/image_swipper.dart';

/*
 *  CLASE:        FullScreenImage
 *  DESCRIPCIÓN:  widget para mostrar imágenes deslizables a pantalla completa 
 */
class FullScreenImage extends StatefulWidget {
  final Product product;

  /*
   * Pre:   producto es un Product con imágenes
   * Post:  ha construido el widget
   */
  FullScreenImage({Key key, this.product}) : super(key: key);

  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ImageSwiper(product: widget.product, expandible: false));
  }
}
