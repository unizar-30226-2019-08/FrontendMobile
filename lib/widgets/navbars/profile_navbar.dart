import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/static_stars.dart';

class ProfileNavbar extends StatelessWidget {

  ProfileNavbar();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    double topMargin = height/30;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(height/3.3),
          child: AppBar(
            automaticallyImplyLeading: false,
            flexibleSpace: Container(
              margin: EdgeInsets.only(top: topMargin, right: width/30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(top: topMargin, right: width/30),
                    height: height/5,
                    child: Container(
                      margin: EdgeInsets.only(top: height/15, left: 25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Zaragoza',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 19.0,
                              fontWeight: FontWeight.w300
                            )
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                Translations.of(context).text('online'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.0,
                                fontWeight: FontWeight.w300
                              )                                
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 5.0),
                              child: Icon(Icons.chat_bubble, color: Colors.green),
                            ),                              
                            ],
                          ),
                          StaticStars(1,Colors.white)
                        ],
                      ),
                    )
                  ),
                  Hero(
                    tag: "profileImage",
                    child: CircleAvatar(
                      backgroundImage: AssetImage('assets/images/user_picture.jpg'),
                      radius: 50.0,
                    ),
                  )
                ],
              ),
            ),
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
                Tab(text: Translations.of(context).text('on_sale_tab')),
                Tab(text: Translations.of(context).text('reviews_tab'))
              ],
              labelColor: Colors.black,
              unselectedLabelColor: Colors.white,
            ),
            title: Container(
              margin: EdgeInsets.only(top: 10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  Text(
                    "Juan L.",
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 45.0
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 30.0),
                    onPressed: () {},
                  )              
                ],
              )
            )
          ),
        ),
        body: TabBarView(
          children: [
            Icon(Icons.ac_unit),
            Icon(Icons.access_alarms),
          ],
        ),
      ),
    );
  }
}