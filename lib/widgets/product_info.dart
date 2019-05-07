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
        height: height / 5,
        child: Row(
          children: <Widget>[
            //Columna de estado
            Expanded(
              child: Container(
                  padding: EdgeInsets.only(left: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Translations.of(context).text("state"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                      ),
                      Text(
                          Translations.of(context)
                              .text(this._product.getState()),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontWeight: FontWeight.w300)),
                      getStateIcon(this._product) //Icono de estado
                    ],
                  )),
            ),
            VerticalDivider(width: 2.0, color: Colors.black, indent: 3.0),

            //Columna de envío
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(Translations.of(context).text("ships"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    this._product.getIncludesShipping() == true
                        ? Text(
                            Translations.of(context).text("include_shipping"),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w300))
                        : Text(Translations.of(context).text("not_shipping"),
                            textAlign: TextAlign.center,
                            style: TextStyle(fontWeight: FontWeight.w300)),
                    Icon(this._product.getIncludesShipping()
                        ? Icons.local_shipping
                        : MdiIcons.accountRemove)
                  ],
                ),
              ),
            ),

            VerticalDivider(width: 2.0, color: Colors.black, indent: 3.0),

            //Columna de Favoritos
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(Translations.of(context).text("favourite"),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                    ),
                    Text(this._product.getFavourites().toString(),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.w300)),
                    Icon(Icons.favorite)
                  ],
                ),
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
