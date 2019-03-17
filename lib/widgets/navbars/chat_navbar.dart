import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/screens/my_profile.dart';

enum Interest {
  buys, offers
}

class ChatNavbar extends StatefulWidget implements PreferredSizeWidget {
    ChatNavbar({Key key, this.preferredSize, this.interest}) : super(key: key);

    final Interest interest;
    @override
    final Size preferredSize;

    @override
    _ChatNavbarState createState() => _ChatNavbarState();
}

class _ChatNavbarState extends State<ChatNavbar>{

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double topMargin = height/40;      
      return AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        elevation: 0.0,
        leading: Container(
          margin: EdgeInsets.only(top: topMargin, left: width/30),
          child: GestureDetector(
            child: Hero(
              tag: "profileImage",
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/images/user_picture.jpg')
              )
            ),
            onTap: (){
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyProfile()),
              );
            }
          )
        ),
        title: Text(Translations.of(context).text(widget.interest.toString().split('.').last)),
        actions: <Widget>[
          Container(
            margin: EdgeInsets.only(top: topMargin, right: width/30),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/boli.jpg')
            ),
          ),
        ],
        flexibleSpace: Center(
          child: Container(
            child: Text('últ. vez hoy a las 18:12', style: TextStyle(color: Colors.white),),
            margin: EdgeInsets.only(top:topMargin*3),
          ),
        ),
      );
    }
}