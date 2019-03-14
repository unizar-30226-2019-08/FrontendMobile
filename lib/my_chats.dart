import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';

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
      appBar: SimpleNavbar(preferredSize: Size.fromHeight(height/10)),
    );
  }
}