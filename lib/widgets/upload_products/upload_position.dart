/*
 * FICHERO:     upload_position.dart
 * DESCRIPCIÓN: clases relativas a la posicion del usuario
 * CREACIÓN:    12/05/2019
 */

import 'package:bookalo/widgets/filter/distance_map.dart';
import 'package:flutter/material.dart';

/*
 *  CLASE:        UploadPosition
 *  TODO: Widget sin implementar
 *  DESCRIPCIÓN:  
 */

class UploadPosition extends StatefulWidget {
  final Function(bool) validate;

  const UploadPosition({Key key, this.validate}) : super(key: key);
  @override
  _UploadPositionState createState() => _UploadPositionState();
}

class _UploadPositionState extends State<UploadPosition> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Center(
        child: ListView(
            padding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            children: <Widget>[
          Container(
            child: DistanceMap(
                //TODO: ver que pàrametros necesita
                height: _height * 0.65,
                distanceRadius: 5000),
          ),
        ]));
  }
}
