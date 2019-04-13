/*
 * FICHERO:     sell.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de venta
 * CREACIÓN:    12/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/filter.dart';
import 'package:bookalo/widgets/product_view.dart';
import 'package:bookalo/widgets/social_buttons.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

//TODO: ver vomo importar keepalive
import 'package:bookalo/pages/user_profile.dart';

/*
 *  CLASE:        Sell
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de venta. Contiene una lista con las miniaturas
  *               de los productos del rpopio usuario que tiene a
  *               la venta.
 */
class Sell extends StatefulWidget {
  Sell({Key key}) : super(key: key);

  _SellState createState() => _SellState();
}

class _SellState extends State<Sell> {
  @override


  _fetchPage(int pageNumber, int pageSize) async {
    await Future.delayed(Duration(seconds: 1));//TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      if(index%2==0){
        return MiniProduct(new Product(
            'Fundamentos de álgebra',
            10,
            true,
            'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg',
            ""));
      }else{
        return MiniProduct(new Product(
            'Lápiz',
            0.75,
            false,
            'https://www.kalamazoo.es/content/images/product/31350_1_xnl.jpg',
            ""));
      }
    });
  }

  Widget _buildPage(List page) {
    return ListView(
        shrinkWrap: true,
        primary: false,
        children: page//.map((_miniProduct) => _miniProduct)
    );
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

        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            FloatingActionButton(
              heroTag: "add",//todo: ver formato tags
              child: Icon(Icons.add),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => NewProduct())
                // );
              },
            ),

          ],
        ),
      /*---valido
        body: ListView(
          children: <Widget>[
            MiniProduct(new Product(
                'Fundamentos de álgebra',
                10,
                true,
                'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg',
                "")),
            MiniProduct(new Product(
                'Lápiz',
                0.75,
                false,
                'https://www.kalamazoo.es/content/images/product/31350_1_xnl.jpg',
                "")),
            SocialButtons()
          ],
        )
      //--valido */

      //-- lista infinita
        body: ListView.builder(
          itemBuilder: (context,pageNumber){
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
                    }break;
                  case ConnectionState.active:
                }
              },
            );
          },
        )
      //-- lista infinita


    );
  }
}
