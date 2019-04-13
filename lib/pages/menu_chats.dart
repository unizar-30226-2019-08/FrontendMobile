/*
 *  CLASE:        menuChats
 *  DESCRIPCIÓN:  widget para el cuerpo principal del visor de chats abierto
 *                de un usuario. Los chats se dividen en dos listas: una para los
 *                artícullos que el usuario quiere comprar y otra para los que quiere vender
 *                
 */



import 'package:flutter/material.dart';
import 'package:bookalo/widgets/valoration_card.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/widgets/navbars/main_navbar.dart';
import 'package:flutter/rendering.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/miniature_chat.dart';
import 'package:bookalo/widgets/navbars/simple_navbar.dart';


class menuChats extends StatelessWidget {
  menuChats({Key key,this.salesChat}):super(key: key);

 
  final bool salesChat;//vale true si el mensaje se ha enviado 
  

  @override
  Widget build(BuildContext context) {
   var user=new User ("Paco","https://raw.githubusercontent.com/josman231/FrontendMobile/master/assets/images/user_picture.jpg");
    var product=new Product("mesa", 20, false, "https://github.com/unizar-30226-2019-08/FrontendMobile/blob/master/assets/images/product_picture.jpg",'esta chulo',false,'nuevo',30);
  final bool lastWasMe=true; //vale true si el usuario es el autor del ultimo mensaje
  final String lastMessage='hola'; //ultimo mensaje enviado en el chat
  final bool closed=true; //vale true si la transacción está cerrada
  final DateTime lastTimeDate=DateTime.now(); //indica la fecha de la última conexión




    var user2=new User ("Paco","https://raw.githubusercontent.com/josman231/FrontendMobile/master/assets/images/user_picture.jpg");
    var product2=new Product("mesa", 20, false, "https://github.com/unizar-30226-2019-08/FrontendMobile/blob/master/assets/images/boli.jpg",'esta chulo tambien',true,'nuevo',34);
  final bool lastWasMe2=false; //vale true si el usuario es el autor del ultimo mensaje
  final String lastMessage2='muy buenas'; //ultimo mensaje enviado en el chat
  final bool closed2=false; //vale true si la transacción está cerrada
  final DateTime lastTimeDate2=DateTime.now(); //indica la fecha de la última conexión
  


double height = MediaQuery.of(context).size.height;
    
      return new Scaffold(
        appBar:SimpleNavbar(
          preferredSize: Size.fromHeight(height/10),
        ),
        body:
          new ListView(
          
          children:[
          Text("Mis chats de compra",
          style: TextStyle(fontWeight:FontWeight.w300,
                            height:1.0,
                            fontSize: 30,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy),),
           MiniatureChat(user:user2,product:product2,lastWasMe:true,lastMessage:lastMessage,closed:closed,lastTimeDate:lastTimeDate),
          MiniatureChat(user:user,product:product,lastWasMe:true,lastMessage:lastMessage,closed:closed,lastTimeDate:lastTimeDate),
           


            Padding(
              padding: new EdgeInsets.all(30.0),
            ),


            Text("Mis chats de venta",
            style: TextStyle(fontWeight:FontWeight.w300, 
                            height:1.0,
                            fontSize: 30,
                            decoration: TextDecoration.underline,
                            decorationStyle: TextDecorationStyle.wavy),),
           MiniatureChat(user:user,product:product,lastWasMe:true,lastMessage:lastMessage,closed:closed,lastTimeDate:lastTimeDate),
          MiniatureChat(user:user2,product:product2,lastWasMe:true,lastMessage:lastMessage,closed:closed,lastTimeDate:lastTimeDate),
       



          ]
         )
         
         );

         
    
  

         
          
}

}
