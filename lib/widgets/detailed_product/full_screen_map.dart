/*
 * FICHERO:     full_screen_map.dart
 * DESCRIPCIÓN: relativo al widget FullScreenMap
 * CREACIÓN:    25/04/2019
 */
import 'package:flutter/material.dart';
import 'package:latlong/latlong.dart';
import 'package:bookalo/widgets/detailed_product/product_map.dart';

/*
 *  CLASE:        FullScreenMap
 *  DESCRIPCIÓN:  widget para mostrar un mapa a pantalla completa centrado en un
 *                área circular de 1km de radio
 */
class FullScreenMap extends StatelessWidget {
  final LatLng position;
  /*
   * Pre:   position es un objeto de tipo LatLong entorno al que se centra el mapa
   * Post:  se ha construido el widget
   */
  FullScreenMap({Key key, this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProductMap(position: position, expandible: false)
    );
  }
}
