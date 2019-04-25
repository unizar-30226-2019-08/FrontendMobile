/*
 * FICHERO:     buy_and_sell.dart
 * DESCRIPCIÓN: clases relativas al la página de selección de compra/venta
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_list_navbar.dart';
import 'package:bookalo/pages/chats_list.dart';



/*
 *  CLASE:        BuyAndSell
 *  DESCRIPCIÓN:  widget para la selección de bien la pestaña de compra,
 *                bien la de venta. Permite deslizado de una a otra
 */
class ChatMenu extends StatelessWidget {
  ChatMenu();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
       appBar:ChatListNavbar(
          preferredSize: Size.fromHeight(height/5),
        ),
        body: TabBarView(
          children: [ChatsList(buyChats:true),ChatsList(buyChats:false)],
        ),
      ),
    );
  }
}
