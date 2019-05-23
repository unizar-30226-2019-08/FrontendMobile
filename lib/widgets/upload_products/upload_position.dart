/*
 * FICHERO:     upload_position.dart
 * DESCRIPCIÓN: clases relativas a la posicion del usuario
 * CREACIÓN:    12/05/2019
 */

import 'package:bookalo/widgets/detailed_product/product_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong/latlong.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

/*
 *  CLASE:        UploadPosition
 *  DESCRIPCIÓN:  
 */

class UploadPosition extends StatefulWidget {
  final Function(bool) validate;
  final Function(LatLng) onPositionChange;
  final LatLng initialPosition;
  const UploadPosition({Key key, this.validate, this.initialPosition, this.onPositionChange})
      : super(key: key);
  @override
  _UploadPositionState createState() => _UploadPositionState();
}

class _UploadPositionState extends State<UploadPosition> {
  LatLng _position;
  bool _loadingNewLocation = false;

  @override
  void initState() {
    super.initState();
    _position = widget.initialPosition;
  }

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.topRight,
      children: <Widget>[
        ProductMap(
          expandible: false,
          position: _position,
          height: _height,
        ),
        (_loadingNewLocation
            ? BookaloProgressIndicator()
            : Material(
                color: Colors.transparent,
                elevation: 10.0,
                child: IconButton(
                    icon:
                        Icon(Icons.my_location, size: 40.0, color: Colors.pink),
                    onPressed: () async {
                      setState(() => _loadingNewLocation = true);
                      Geolocator()
                          .getCurrentPosition(
                              desiredAccuracy: LocationAccuracy.high)
                          .then((newPosition) {
                        setState(() {
                          _loadingNewLocation = false;
                          _position = LatLng(
                              newPosition.latitude, newPosition.longitude);
                        });
                        widget.onPositionChange(LatLng(
                            newPosition.latitude, newPosition.longitude));
                      });
                    }),
              ))
      ],
    );
  }
}
