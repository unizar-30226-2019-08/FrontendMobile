/*
 * FICHERO:     Product_info.dart
 * DESCRIPCIÓN: Características del producto
 * CREACIÓN:    13/04/2019
 */

import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/objects/product.dart';

/*
  CLASE: ProductInfo
  DESCRIPCIÓN:Proporciona información del producto 
              sobre su estado, si incluye envío y el número de likes
 */

class ProductInfo extends StatelessWidget {
  final Product _product;

  ProductInfo(this._product);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
        width: width,
        height: height / 10,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    Translations.of(context).text("state"),
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                          Translations.of(context)
                              .text(this._product.getState()),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      Container(width: 5),
                      getStateIcon(this._product)
                    ],
                  ) //Icono de estado
                ],
              ),
            ),
            VerticalDivider(color: Colors.black, indent: 3.0),
            //Columna de Favoritos
            Container(
              width: width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).text("favourite"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(this._product.getFavourites().toString() + ' x ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      Icon(Icons.favorite, color: Colors.pink)
                    ],
                  )
                ],
              ),
            ),
            VerticalDivider(color: Colors.black, indent: 3.0),
            //Columna de envío
            Container(
              width: width / 3.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(Translations.of(context).text("ships"),
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 20)),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      this._product.isShippingIncluded() == true
                          ? Text(
                              Translations.of(context).text("include_shipping"),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w300))
                          : Text(Translations.of(context).text("not_shipping"),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontWeight: FontWeight.w300)),
                      Container(width: 5),
                      Icon(this._product.isShippingIncluded()
                          ? Icons.local_shipping
                          : MdiIcons.accountRemove)
                    ],
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget getStateIcon(Product product) {
    switch (product.getState()) {
      case "Nuevo":
        return Icon(Icons.fiber_new);
      case "Seminuevo":
        return Icon(MdiIcons.walletTravel);
      case "Usado":
        return Icon(Icons.restore_page);
      default:
        return Container();
    }
  }
}
