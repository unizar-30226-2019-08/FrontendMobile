import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';

class MyChats extends StatefulWidget {

  MyChats();
  //MyChats({Key key, this.child}) : super(key: key);

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