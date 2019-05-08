/*
 * FICHERO:     MyChats.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/widgets/bubble_chat.dart';
import 'package:lipsum/lipsum.dart' as lipsum;
import 'package:bookalo/widgets/valoration_card.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/objects_generator.dart';

import 'dart:math';

/*
 *  CLASE:        Chat
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de un chat concreto
 */
class Chat extends StatefulWidget {
  Chat();

  _ChatState createState() => _ChatState();
}

  








class _ChatState extends State<Chat> {
  bool closed=false;
  
  
void setClosed(BuildContext context)=> setState(() => closed = true);

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    User user = generateRandomUser();
    final items = List<Bubble>.generate(
  10,
  (i) => i % 6 == 0
      ? Bubble(isMe:true,
                    user:user,
                     message: lipsum.createSentence(),
                     sent:Random().nextDouble() > 0.5 ,
                    time: DateTime.now())
      : Bubble(isMe:false ,
                    user:user,
                     message: lipsum.createSentence(),
                     sent:Random().nextDouble() > 0.5 ,
                    time: DateTime.now())
    
);
    return Scaffold(
      appBar: ChatNavbar(
          preferredSize: Size.fromHeight(height / 10), interest: Interest.buys),
      body:
        
         ListView(
        children: <Widget>[
        
          
          OutlineButton(
                        borderSide: BorderSide(color: Colors.pink, width: 3.0),
                        
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20.0))),
                        child: Text(
                          Translations.of(context).text("close_chat"),
                          style: TextStyle(
                              color: Colors.pink[600],
                              fontWeight: FontWeight.w700),
                        ),
                        onPressed: () {
                          //comprobar si la información introducida es válida al pulsar
                          setClosed(context);
                        },
                      ),
       
        ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    final item = items[index];
    return item;
  }
        ),




         /* Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: true,
            isMe: false,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: true,
            isMe: true,
          ),
          Bubble(
            message: lipsum.createSentence(),
            user: user,
            time: DateTime.now(),
            sent: false,
            isMe: false,
          ),*/
    
          
          closed == false ? Container(height:30):ValorationCard( userToValorate: user,
            currentUser: user),   
          Container(height:50.0),
          Padding(padding: const EdgeInsets.only(bottom: 30.0),
                  child:
           Container(
                  margin: EdgeInsets.only(bottom: 1.0),
                  child:
           TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 15),
                border:  OutlineInputBorder(borderRadius:BorderRadius.circular(32.0)),
                suffixIcon: IconButton(
                      icon: Icon(Icons.send),
                      onPressed:null)),
              
             keyboardType: TextInputType.text,
                      maxLines: null,
                     ),

           // IconButton(icon:Icon(Icons.send,size:50.0), onPressed:null )
         
                  
          ))]
      ),
    );
  }
}
