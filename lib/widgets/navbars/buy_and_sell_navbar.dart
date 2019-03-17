import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/screens/my_chats.dart';
import 'package:bookalo/screens/my_profile.dart';

class BuyAndSellNavbar extends StatefulWidget implements PreferredSizeWidget {
    BuyAndSellNavbar({Key key, this.preferredSize, }) : super(key: key);

    @override
    final Size preferredSize;

    @override
    _BuyAndSellNavbarState createState() => _BuyAndSellNavbarState();
}

class _BuyAndSellNavbarState extends State<BuyAndSellNavbar>{

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double topMargin = height/40;      
      return PreferredSize(
        preferredSize: Size.fromHeight(height/5),
        child: AppBar(
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(top: topMargin, right: width/30),
              child: IconButton(
                icon: Icon(Icons.chat_bubble_outline, color: Colors.white, size: 35.0),
                onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyChats()),
                  );
                }
              ),
            ),
            GestureDetector(
              child: Container(
                margin: EdgeInsets.only(top: topMargin, right: width/30),
                child: Hero(
                  tag: "profileImage",
                  child: CircleAvatar(
                    backgroundImage: AssetImage('assets/images/user_picture.jpg')
                  ),
                )
              ),
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProfile()),
                );
              }
            )
          ],
          elevation: 0.0,
          bottom: TabBar(
            indicatorWeight: 3.0,
            labelStyle: TextStyle(
              fontSize: 20.0, 
              fontWeight: FontWeight.w300),
            indicator: BoxDecoration(
              color: Theme.of(context).canvasColor
            ),
            tabs: [
              Tab(text: Translations.of(context).text('buy_tab')),
              Tab(text: Translations.of(context).text('sell_tab'))
            ],
            labelColor: Colors.black,
            unselectedLabelColor: Colors.white,
          ),
          title: Container(
            margin: EdgeInsets.only(top: topMargin),
            child: Image.asset('assets/images/bookalo_logo.png', width: width/2),
          )
        ),
      );
    }
}
