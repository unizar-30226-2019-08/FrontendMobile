/*
 * FICHERO:     chats_list.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de chats de compra
 * CREACIÓN:    20/04/2019
 */
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
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
  bool _hasChats;
  ChatsList({Key key, this.buyChats}) : super(key: key) {
    this._hasChats = Random().nextDouble() > 0.2;
  }

  @override
  State<ChatsList> createState() {
    return _ChatsListState();
  }
}

class _ChatsListState extends State<ChatsList> {
  bool alreadyChecked = false;

  Future<List<Widget>> _fetchPage(int pageSize, double height) async {
    await Future.delayed(Duration(seconds: 1));
    if (widget._hasChats) {
      return List<MiniatureChat>.generate(8, (index) {
        return widget.buyChats
            ? MiniatureChat(
                user: generateRandomUser(),
                product: generateRandomProduct(),
                lastWasMe: true,
                lastMessage: 'Soy un vendedor',
                closed: false,
                lastTimeDate: DateTime.now(),
                isBuyer: false)
            : MiniatureChat(
                user: generateRandomUser(),
                product: generateRandomProduct(),
                lastWasMe: true,
                lastMessage: 'Soy un comprador',
                closed: false,
                lastTimeDate: DateTime.now(),
                isBuyer: true);
      });
    } else {
      if (!alreadyChecked) {
        alreadyChecked = true;
        return List.of([
          Center(
            child: Container(
              margin: EdgeInsets.only(top: height / 5),
              child: Column(
                children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(bottom: height / 25),
                      child: Icon(Icons.remove_shopping_cart,
                          size: 80.0, color: Colors.pink)),
                  Text(
                    Translations.of(context).text("no_products_available"),
                    style:
                        TextStyle(fontSize: 25.0, fontWeight: FontWeight.w300),
                  )
                ],
              ),
            ),
          )
        ]);
      } else {
        return List.of([]);
      }
    }
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Pagination<Widget>(
      progress: Container(
          margin: EdgeInsets.symmetric(vertical: height / 20),
          child: BookaloProgressIndicator()),
      pageBuilder: (currentSize) => _fetchPage(currentSize, height),
      itemBuilder: (index, item) {
        return item;
      },
    ));
  }
}
