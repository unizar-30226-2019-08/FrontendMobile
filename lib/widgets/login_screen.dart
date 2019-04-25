/*
 * FICHERO:     login_screen.dart
 * DESCRIPCIÓN: pantalla de login
 * CREACIÓN:    5/04/2019
 */


import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        LoginScreen
 *  DESCRIPCIÓN:  Pantalla de inicio de sesión
 */



class LoginScreen extends StatelessWidget {

  LoginScreen();

_launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
 
  @override
  Widget build(BuildContext context) {
    var logo=AssetImage('assets/bookalo_logo.jpeg');//logo de bookalo.(Insertar asset en pubspec)
    var bookaloImage=new Image(image:logo);
    var height2 = 50.0;
        return Scaffold(
          body:Column(
            //Bienvenida
            children:[Center(child: Text(Translations.of(context).text("Welcome"),
                             textAlign:TextAlign.center,
                             style:TextStyle(fontSize:50.0),),),
                    //Foto del logo
                     bookaloImage,
    
    
                    //Mensaje de bienvenida
                      Center(child: Text(Translations.of(context).text("Welcome_text"),
                                          textAlign: TextAlign.center,
                                          style:TextStyle(fontSize:20.0),),),
    
                     
    
    
    
                      //Botones inicio sesión
                      Row(
                         mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
    
                        
                        children: <Widget>[
                          //Botón de twitter
                          ButtonTheme(
                            minWidth:50,
                            height:height2,   
                        child:RaisedButton(
                        onPressed: () {
                    _launchURL('http://twitter.com');
                  },
                      
                      color:Colors.cyan,
                    
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Twitter"),
                          Icon(
                             MdiIcons.twitter,
                             color: Colors.blue[900],
                              size: 30.0,
                          )
                      
                        ],
                      ),
                    ),
                          )
                    ]
                  ),

                 Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //Google
                    children: <Widget>[
                      ButtonTheme(
                       minWidth:50,
                       height:height2,
                  
                       child:RaisedButton(
                        onPressed: () {
                    _launchURL('http://google.com');
                  },
                      color:Colors.red,
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Google"),
                          Icon(
                             MdiIcons.google,
                             color:Colors.white,
                              size: 30.0,
                          )
                        ],
                      ),
                       )
                      )
                    ]
                  ),







                  Row(
                     mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    children:[
                      //Facebook
                    ButtonTheme(
                      minWidth:50,
                      height:height2,

                     child:RaisedButton(
                        onPressed: () {
                    _launchURL('http://facebook.com');
                  },
                      color:Colors.lightBlue[900],
                      child:Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Text("Facebook"),
                           Icon(
                         MdiIcons.facebook,
                    color: Colors.white,
                    size: 30.0,
                              ),
                 
                        ]
                      ),
                      ),
                    )
                    ],
                    
                  )

                                       
        ])
    );
  }



}