/*
 * FICHERO:     distance_chip.dart
 * DESCRIPCIÓN: clases relativas al widget visor de distancia
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:geo/geo.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        DistanceChip
 *  DESCRIPCIÓN:  widget para mostrar distancia hasta un producto. Calcula
 *                la distancia dadas dos posiciones y la muestra en el formato
 *                adecuado
 */
class DistanceChip extends StatelessWidget {
  final LatLng userPosition;
  final LatLng targetPosition;

  /*
   * Pre:   p1 y p2 son dos objetos LatLng representando respectivamente
   *        la posición actual del usuario y la del producto; context
   *        es el contexto actual de ejecución
   * Post:  ha devuelto una cadena de texto con la distancia en el formato
   *        adecuado
   */ 
  String distanceToString(LatLng p1, LatLng p2, BuildContext context){
    double distance = computeDistanceBetween(p1, p2);
    if(distance < 100){
      return Translations.of(context).text("very_close");
    }
    if(distance < 1000){
      return distance.toStringAsFixed(0) + ' m';
    }
    if(distance < 10000){
      return (distance/1000).toStringAsFixed(1) + ' km';  
    }
    return (distance/1000).toStringAsFixed(0) + ' km';
  }

  /*
   * Pre:   userPosition es un objeto LatLng de la libreria geo que representa
   *        la posición actual del usuario. targetPosition también es un obejto
   *        LatLng que representa la posición del producto
   * Post:  
   */ 
  DistanceChip({Key key, this.userPosition, this.targetPosition}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Chip(
      label: Text(
        distanceToString(userPosition, targetPosition, context),
        style: TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          fontWeight: FontWeight.w300
        ),
      ),
      backgroundColor: Colors.pink,
    );
  }
}