/*
 * FICHERO:     buy.dart
 * DESCRIPCIÓN: clases relativas al la pestaña de compra
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/social_buttons.dart';
import 'package:bookalo/utils/objects_generator.dart';

/*
 *  CLASE:        Buy
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de compra. Contiene una lista con los productos
 *                obtenidos según las opciones de filtrado.
 */
class Buy extends StatefulWidget {
  Buy({Key key}) : super(key: key);

  _BuyState createState() => _BuyState();
}

class _BuyState extends State<Buy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton.extended(
              heroTag: "searchFAB",
              icon: Icon(Icons.search),
              label: Text(Translations.of(context).text('search')),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => Filter())
                // );
              },
            ),
            SizedBox(
              height: 16.0,
            ),
            FloatingActionButton.extended(
              heroTag: "filterFAB",
              icon: Icon(Icons.sort),
              label: Text(Translations.of(context).text('filter')),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Filter()));
              },
            ),
          ],
        ),
        // body: Center(
        //   child: Container(
        //     margin: EdgeInsets.only(top: height/5),
        //     child: Column(
        //       children: <Widget>[
        //         Container(
        //           margin: EdgeInsets.only(bottom: height/25),
        //           child: Icon(Icons.remove_shopping_cart, size: 80.0, color: Colors.pink)
        //         ),
        //         Text(
        //           Translations.of(context).text("no_products_available"),
        //           style: TextStyle(
        //             fontSize: 25.0,
        //             fontWeight: FontWeight.w300
        //           ),
        //         )
        //       ],
        //     ),
        //   ),
        // )
        body: ListView(
          children: <Widget>[
            ProductView(generateRandomProduct(), 6.1, 39),
            ProductView(generateRandomProduct(), 6.1, 39),
            SocialButtons()
          ],
        ));
  }
}
