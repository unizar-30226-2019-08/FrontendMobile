/*
 * FICHERO:     product_map.dart
 * DESCRIPCIÓN: clases relativas al widget ProductMap
 * CREACIÓN:    26/04/2019
 */
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:bookalo/widgets/detailed_product/full_screen_map.dart';

/*
 *  CLASE:        ProductMap
 *  DESCRIPCIÓN:  widget para la visualización de la posición de un producto
 */
class ProductMap extends StatelessWidget {
  final double height;
  final LatLng position;
  final bool expandible;

  /*
   * Pre:   position es un objeto de tipo LatLong que representa el
   *        lugar de venta del producto. height es la altura en píxeles
   *        del widget. expandible indica si es el widget deberá expandirse 
   *        a pantalla completa al ser tocado. 
   *        REQUIERE PERMISOS DE INTERNET Y LOCALIZACIÓN
   * Post:  ha construido el widget haciendo uso de OpenStreetMap
   */
  ProductMap({Key key, this.position, this.height, this.expandible})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: FlutterMap(
          options: MapOptions(
              onTap: (x) {
                if (expandible) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FullScreenMap(
                                position: this.position,
                              )));
                }
              },
              center: this.position,
              maxZoom: 13.0,
              minZoom: 8.0,
              zoom: 12.0),
          layers: [
            TileLayerOptions(
                urlTemplate:
                    "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                subdomains: ['a', 'b', 'c']),
            CircleLayerOptions(circles: [
              CircleMarker(
                  point: this.position,
                  color: Colors.pink.withOpacity(0.5),
                  useRadiusInMeter: true,
                  radius: 1000)
            ])
          ]),
    );
  }
}
