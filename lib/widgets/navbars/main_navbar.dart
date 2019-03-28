import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/my_chats.dart';
import 'package:bookalo/my_profile.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/widgets/product_view.dart';

class MainNavbar extends StatelessWidget {

  MainNavbar();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height/60;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
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
        ),
        body: TabBarView(
          children: [
            //Icon(Icons.ac_unit),
            ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    ProductView(new Product('Libro', 9999.5, true, 'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg')
                        ,6.1,39),
                    ProductView(new Product('Libro', 9999.5, true, 'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg')
                        ,6.1,39),
                  ],
                ),

              ],
            ),

            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}