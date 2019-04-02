/*
 * FICHERO:     profile_navbar.dart
 * DESCRIPCIÓN: clases relativas al widget de barra de navegación 
 *              del perfil de usuario
 * CREACIÓN:    13/03/2019
 */
import 'package:flutter/material.dart';
import 'package:share/share.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        ProfileNavbar
 *  DESCRIPCIÓN:  widget para barra de navegación del perfil de usuario. Muestra
 *                el nombre de usuario, su ubicación, si está en línea, opciones 
 *                de compartición, su valoración media y su foto
 */
class ProfileNavbar extends StatefulWidget implements PreferredSizeWidget {
    /*
     * Pre:   preferredSize es un objeto tipo Size del que se debe construir
     *        el parámetro height y que especifica la altura de la barra de
     *        navegación
     * Post:  ha construido el widget
     */  
    ProfileNavbar({Key key, this.preferredSize, }) : super(key: key);

    @override
    final Size preferredSize;

    @override
    _ProfileNavbarState createState() => _ProfileNavbarState();
}

class _ProfileNavbarState extends State<ProfileNavbar>{

    @override
    Widget build(BuildContext context) {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      double topMargin = height/40;      
      return PreferredSize(
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
                          //MOCKUP mientras no esté el visor de estrellas
                          Container(
                            margin: EdgeInsets.only(top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Icon(Icons.star, color: Colors.white),
                                Icon(Icons.star, color: Colors.white),
                                Icon(Icons.star, color: Colors.white),
                                Icon(Icons.star, color: Colors.white)
                              ],
                            )
                          ),
                        ],
                      ),
                    )
                  ),
                  GestureDetector(
                    child: Hero(
                      tag: "profileImage",
                      child: CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user_picture.jpg'),
                        radius: 50.0,
                      ),
                    ),
                    onTap: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => BigProfileImage(
                          image: AssetImage('assets/images/user_picture.jpg')
                        )),
                      );                      
                    },
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
                    onPressed: () {
                      Share.share(
                        Translations.of(context).text('share_profile', params: ['Juan']) + 'https://bookalo.es/user=123'
                      );
                    },
                  )              
                ],
              )
            )
          ),
        );
    }
}

class BigProfileImage extends StatelessWidget {
  final AssetImage image;
  BigProfileImage({Key key, this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){Navigator.pop(context);},
      child: Scaffold(
        backgroundColor: Colors.pink,
        body: Center(
            child: Hero(
              tag: "profileImage",
              child: CircleAvatar(
                backgroundImage: image,
                radius: width/2.2,
              ),
            )
        ),
      ),
    );
  }
}