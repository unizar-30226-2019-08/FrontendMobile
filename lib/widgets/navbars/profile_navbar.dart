import 'package:flutter/material.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/static_stars.dart';
import 'package:bookalo/widgets/mini_product.dart';
import 'package:bookalo/widgets/miniatura_valoracion.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/objects/usuario.dart';

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
                          StaticStars(1,Colors.white,7)
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
            //Icon(Icons.ac_unit),
            Column(
              children: <Widget>[
                MiniProduct(new Product('Libro', 9.5, true, 'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg')),
                MiniProduct(new Product('Lápiz', 0.75, false, 'https://www.kalamazoo.es/content/images/product/31350_1_xnl.jpg')),
              ],
            ),

            //Icon(Icons.access_alarms),
            Column(
              children: <Widget>[
                MiniaturaValoracion(new Usuario('Silvia M.','https://secure.gravatar.com/avatar/b10f7ddbf9b8be9e3c46c302bb20101d?s=400&d=mm&r=g'),160219,false,
                    new Product('Libro', 9.5, true,
                        'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg'),
                    'Muy buena compradora', 8.4),
                MiniaturaValoracion(new Usuario('Laura P.','https://secure.gravatar.com/avatar/b10f7ddbf9b8be9e3c46c302bb20101d?s=400&d=mm&r=g'),160219,false,
                    new Product('Libro', 9.5, false,
                        'https://www.ecured.cu/images/thumb/8/81/Libro_abierto.jpg/260px-Libro_abierto.jpg'),
                    'No fue puntual', 2)
              ],

            )

          ],
        ),
      ),
    );
  }
}