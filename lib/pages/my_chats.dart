/*
 * FICHERO:     MyChats.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';

/*
 *  CLASE:        MyChats
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de filtrado.
 *                Consiste en dos listas diferenciadas de chats con compradores
 *                y vendedores.
 *                TEMPORALMENTE CONTIENE NAVBAR DE CHAT CONCRETO. NO SERÁ ASÍ.
 */
class MyChats extends StatefulWidget {

  MyChats();

  _MyChatsState createState() => _MyChatsState();
}

class _MyChatsState extends State<MyChats> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ChatNavbar(preferredSize: Size.fromHeight(height/10), interest: Interest.buys),
    );
  }
}