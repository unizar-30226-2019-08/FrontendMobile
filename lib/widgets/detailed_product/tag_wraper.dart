/*
 * FICHERO:     tap_wraper.dart
 * DESCRIPCIÓN: clases relativas al widget TagWraper
 * CREACIÓN:    19/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';

/*
 *  CLASE:        TagWraper
 *  DESCRIPCIÓN:  widget para mostrar tags de un producto
 */
class TagWraper extends StatelessWidget {
  final Product product;

  /*
   * Pre:   product es un objeto de la clase Product
   * Post:  ha constuido el widget
   */
  TagWraper({Key key, this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: List.generate(product.getTags().length, (i) {
        return Chip(
          label: Text(
            product.getTags()[i],
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400),
          ),
          backgroundColor: Colors.pink,
        );
      }),
      spacing: 5.0,
    );
  }
}
