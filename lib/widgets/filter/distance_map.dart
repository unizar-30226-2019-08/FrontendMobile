/*
 * FICHERO:     distance_map.dart
 * DESCRIPCIÓN: clases relativas al widget DistanceMap
 * CREACIÓN:    19/03/2019
 */
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

/*
 *  CLASE:        DistanceMap
 *  DESCRIPCIÓN:  widget para la visualización de la máxima distancia
 *                de búsqueda en la página de filtrado
 */
class DistanceMap extends StatelessWidget {
  final double distanceRadius;
  final double height;

  /*
   * Pre:   distanceRadius es la distancia en metros que se desea dibujar entorno
   *        a la localización de actual del usuario. height es la altura en píxeles
   *        del widget. REQUIERE PERMISOS DE INTERNET Y LOCALIZACIÓN
   * Post:  ha construido el widget haciendo uso de OpenStreetMap
   */ 
  DistanceMap({Key key, this.distanceRadius, this.height}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      child: FutureBuilder<Position>(
        future: _getUserPosition(),
        builder: (BuildContext context, AsyncSnapshot<Position> snapshot){
          if(snapshot.hasData){
            return FlutterMap(
              options: MapOptions(
                center: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                maxZoom: 12.0,
                minZoom: 8.0,
                zoom: 10.0
              ),
              layers: [
                TileLayerOptions(
                  urlTemplate:"https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c']),
                  CircleLayerOptions(
                    circles: [
                      CircleMarker(
                        point: LatLng(snapshot.data.latitude, snapshot.data.longitude),
                        color: Colors.pink.withOpacity(0.7),
                        useRadiusInMeter: true,
                        radius: distanceRadius
                      )
                    ]
                  )
              ]
            );
          }else{
            return Center(child: BookaloProgressIndicator());
          }
        },
      ),
    );
  }

  Future<Position> _getUserPosition() async{
    return await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

}