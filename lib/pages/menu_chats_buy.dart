/*
 * FICHERO:     menu_chats_buy.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de chats de compra
 * CREACIÓN:    20/04/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/list_viewer.dart';
import 'package:bookalo/utils/objects_generator.dart';
import 'package:bookalo/widgets/miniature_chat.dart';

/*
 *  CLASE:        MenuChatsBuy
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de chats de compra. Contiene una lista con las miniaturas
  *               de los chats iniciados con vendedores
  *               
 */
class MenuChatsBuy extends StatefulWidget {
 final bool buyChats;
  MenuChatsBuy({Key key,this.buyChats}) : super(key: key);

  @override
  State<MenuChatsBuy> createState() {
    return _MenuChatsBuyState();
  }
}

class _MenuChatsBuyState extends State<MenuChatsBuy> {
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
                    isBuyer: false
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

  bool isBuyChat(){
    return widget.buyChats;
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
        
        isBuyChat() ? 
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
         )
         :

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
        )
    );
  }
}
