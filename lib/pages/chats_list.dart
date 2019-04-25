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
import 'package:paging/paging.dart';

/*
 *  CLASE:        ChatsList
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de chats de compra. Contiene una lista con las miniaturas
  *               de los chats iniciados con vendedores
  *               
 */
class ChatsList extends StatefulWidget {
 final bool buyChats;
  ChatsList({Key key,this.buyChats}) : super(key: key);

  @override
  State<ChatsList> createState() {
    return _ChatsListState();
  }
}

class _ChatsListState extends State<ChatsList> {
    /*
      Pre: pageNumber >=0 y pageSize > 0
      Post: devuelve una lista con pageSize MiniProduct
   */
  _fetchPage(int pageNumber, int pageSize) async {
    await Future.delayed(
        Duration(seconds: 1)); //TODO: solo para visualizacion  de prueba

    return List.generate(pageSize, (index) {
      Widget Miniature;
      widget.buyChats==true ?
        Miniature= MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: 'Soy un vendedor',
                    closed: false,
                    lastTimeDate: DateTime.now(),
                    isBuyer: false
              )
          :
          Miniature= MiniatureChat(
                    user: generateRandomUser(),
                    product: generateRandomProduct(),
                    lastWasMe: true,
                    lastMessage: 'Soy un comprador',
                    closed: false,
                    lastTimeDate: DateTime.now(),
                    isBuyer: true
              );
return Miniature;
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
         )
         

    );
  }
}
