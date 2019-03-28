import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message,this.usuario, this.time, this.sent, this.isMe});

  final String message; //mensaje del usuario
  final String time; //tiempo de ultimo mensaje
  final String usuario; //nombre de usuario
  final bool sent;//vale true si el mensaje se ha enviado 
  final bool  isMe;//vale true si el mensajelo envío yo

  @override
  Widget build(BuildContext context) {
    final bg = isMe ? Colors.pink[200] : Colors.pink; //el color del bubble cambia dependiendo de quién envía el mensaje
    final align = isMe ? CrossAxisAlignment.start : CrossAxisAlignment.end; // el mensaje estará a un lado 
                                                                            //o a otro de la pantalla depndeiendo de quién envía el mensaje
    final icon = sent ? Icons.done_all : Icons.done; //si el mensaje se ha enviado saldrán dos tics y si no uno
    final radius = isMe
        ? BorderRadius.only(//si el mensaje es mio, se redondean todas las esquinas del bubble excepto la superior dcha
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
           // topLeft: Radius.circular(5.0)
          )
        : BorderRadius.only(//si no, se redondean todas menos la superior izda
            //topRight:Radius.circular(5.0) ,
            topLeft: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
          );
    return Column(
      crossAxisAlignment: align,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.all(3.0),
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                  blurRadius: .5,
                  spreadRadius: 1.0,
                  color: Colors.black.withOpacity(.12))
            ],
            color: bg,
            borderRadius: radius,
          ),
          child: Stack(
            children: <Widget>[
              Row(children: <Widget>[
                  Text(isMe ? "Tu" :usuario,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 8.0,
                        )),
                    ],),
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(message),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(time,
                        style: TextStyle(
                          color: Colors.black38,
                          fontSize: 10.0,
                        )),
                    SizedBox(width: 3.0),
                    Icon(
                      icon,
                      size: 12.0,
                      color: Colors.black38,
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}

/*class BubbleScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade50,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: .9,
        title: Text(
          'Putra',
          style: TextStyle(color: Colors.green),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.videocam,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.call,
              color: Colors.green,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.more_vert,
              color: Colors.green,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Bubble(
              message: 'Hi there, this is a message',
              time: '12:00',
              delivered: true,
              isMe: false,
            ),
            Bubble(
              message: 'Whatsapp like bubble talk',
              time: '12:01',
              delivered: true,
              isMe: false,
            ),
            Bubble(
              message: 'Nice one, Flutter is awesome',
              time: '12:00',
              delivered: true,
              isMe: true,
            ),
            Bubble(
              message: 'I\'ve told you so dude!',
              time: '12:00',
              delivered: true,
              isMe: false,
            ),
          ],
        ),
      ),
    );
  }
}*/