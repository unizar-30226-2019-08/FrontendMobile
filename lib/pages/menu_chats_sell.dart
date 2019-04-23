/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/list_viewer.dart';
import 'package:bookalo/pages/upload_product.dart';
import 'package:bookalo/utils/objects_generator.dart';
import 'package:bookalo/widgets/miniature_chat.dart';

/*
 *  CLASE:        Sell
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de venta. Contiene una lista con las miniaturas
  *               de los productos del rpopio usuario que tiene a
  *               la venta.
 */
class MenuChatsSell extends StatefulWidget {
  MenuChatsSell({Key key}) : super(key: key);

  _MenuChatsSellState createState() => _MenuChatsSellState();
}

class _MenuChatsSellState extends State<MenuChatsSell> {
  /*
      Pre: pageNumber >=0 y pageSize > 0
      Post: devuelve una lista con pageSize MiniProduct
   */
  _fetchPage(int pageNumber, int pageSize) async {
    await Future.delayed(
        Duration(seconds: 1)); //TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      
        return MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: 'hola',
                    closed: false,
                    lastTimeDate: DateTime.now(),
                    isBuyer: true
              );
      });
  }

  /*
      Pre: ---
      Post: devuelve una ListView con la lista de elementos en page
   */
  Widget _buildPage(List page) {
    return ListView(shrinkWrap: true, primary: false, children: page);
  }

  Widget build(BuildContext context) {
    return Scaffold(
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
        
        
        body: 
        ListView.builder(
          itemBuilder: (context, pageNumber) {
            //Todo: 8 mas o menos por pagina
            //TODO:  obtener producto de la lista
            return KeepAliveFutureBuilder(
              future: this._fetchPage(pageNumber, 8),
              builder: (context, snapshot) {
                switch (snapshot.connectionState) {
                  case ConnectionState.none:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: BookaloProgressIndicator(),
                    );
                  case ConnectionState.waiting:
                    return SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: BookaloProgressIndicator(),
                    );
                  case ConnectionState.done:
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return this._buildPage(snapshot.data);
                    }
                    break;
                  case ConnectionState.active:
                }
              },
            );
          },
        ));
  }
}
