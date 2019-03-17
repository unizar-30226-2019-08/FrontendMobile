import 'package:flutter/material.dart';

class Bubble extends StatelessWidget {
  Bubble({this.mensaje, this.hora, this.enviado, this.soyYo});

  final String mensaje, hora;
  final enviado, soyYo;

  @override
  Widget build(BuildContext context) {
    final bg = soyYo ? Colors.pink[200] : Colors.pink;
    final align = soyYo ? CrossAxisAlignment.start : CrossAxisAlignment.end;
    final icon = enviado ? Icons.done_all : Icons.done;
    final radius = soyYo
        ? BorderRadius.only(
            topRight: Radius.circular(5.0),
            bottomLeft: Radius.circular(5.0),
            bottomRight: Radius.circular(5.0),
           // topLeft: Radius.circular(5.0)
          )
        : BorderRadius.only(
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
              Padding(
                padding: EdgeInsets.only(right: 48.0),
                child: Text(mensaje),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Row(
                  children: <Widget>[
                    Text(hora,
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
              soyYo: false,
            ),
            Bubble(
              message: 'Whatsapp like bubble talk',
              time: '12:01',
              delivered: true,
              soyYo: false,
            ),
            Bubble(
              message: 'Nice one, Flutter is awesome',
              time: '12:00',
              delivered: true,
              soyYo: true,
            ),
            Bubble(
              message: 'I\'ve told you so dude!',
              time: '12:00',
              delivered: true,
              soyYo: false,
            ),
          ],
        ),
      ),
    );
  }
}*/