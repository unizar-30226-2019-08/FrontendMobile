import 'package:flutter/material.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/dates_utils.dart';

class Bubble extends StatelessWidget {
  Bubble({this.message, this.user, this.time, this.sent, this.isMe});

  final String message; //mensaje del usuario
  final DateTime time;    //tiempo de ultimo mensaje
  final User user;      //nombre de usuario
  final bool sent;      //vale true si el mensaje se ha enviado
  final bool isMe;      //vale true si el mensajelo envío yo

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final bg = isMe
        ? Colors.pink[900]
        : Colors.pink[500]; //el color del bubble cambia dependiendo de quién envía el mensaje
    //o a otro de la pantalla depndeiendo de quién envía el mensaje
    final icon = sent
        ? Icons.done_all
        : Icons.done; //si el mensaje se ha enviado saldrán dos tics y si no uno
    final radius = isMe
        ? BorderRadius.only(
            //si el mensaje es mio, se redondean todas las esquinas del bubble excepto la superior izq
            topLeft: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
            // topLeft: Radius.circular(5.0)
          )
        : BorderRadius.only(
            //si no, se redondean todas menos la superior dcha
            //topRight:Radius.circular(5.0) ,
            topRight: Radius.circular(15.0),
            bottomLeft: Radius.circular(15.0),
            bottomRight: Radius.circular(15.0),
          );
    return Container(
      margin: EdgeInsets.only(
        top: 10.0,
        left: (isMe
          ? 2*width/15
          : 0.5*width/15),
        right: (isMe
          ? 0.5*width/15
          : 2*width/15)          
      ),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
              blurRadius: .5,
              spreadRadius: 1.0,
              color: Colors.black.withOpacity(0.12))
        ],
        color: bg,
        borderRadius: radius,
      ),
      child: Stack(
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                isMe
                    ? Translations.of(context).text("you")
                    : user.getName(),
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.w700
                )
              ),
              Text(
                message + '\n',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0
                ),
              )
            ],
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            child: Row(
              children: <Widget>[
                Text(dateToFullString(time, context),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.0,
                    )),
                SizedBox(width: 3.0),
                Icon(
                  icon,
                  size: 12.0,
                  color: Colors.white,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}