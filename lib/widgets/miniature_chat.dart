/*
 * FICHERO:     miniature_chat.dart
 * DESCRIPCIÓN: clases relativas a la  miniatura de un chat
 * CREACIÓN:    14/03/2019
 */

import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';

/*
 *  CLASE:        MiniatureChat
 *  DESCRIPCIÓN:  widget para mostrar la información de un chat aún vigente
 */

class MiniatureChat extends StatelessWidget {
  final User user; //Usuario con el que se chatea
  final Product product; //Producto sobre el que trata el chat
  final bool lastWasMe; //vale true si el usuario es el autor del ultimo mensaje
  final String lastMessage; //ultimo mensaje enviado en el chat
  final bool closed; //vale true si la transacción está cerrada
  final DateTime lastTimeDate; //indica la fecha de la última conexión
  final bool isBuyer;

  MiniatureChat(
      {Key key,
      this.user,
      this.product,
      this.lastWasMe,
      this.lastMessage,
      this.closed,
      this.lastTimeDate,
      this.isBuyer})
      : super(key: key);

  /*
   * Pre:  ---
   * Post: construye el título de la miniatura con el último mensaje y su autor
   */
  Text buildTitle(BuildContext context) {
    String message = ""; //ultimo mensaje enviado
    String author = ""; //nombre de el autor del último mensaje
    if (this.lastMessage.length > 10) {
      //si el mensaje tiene más de 10 caracteres
      message = this.lastMessage.substring(1, 10) +
          "..."; // se muestran los 10 primeros
    } else {
      //si no,se muestra entero
      message = this.lastMessage;
    }

    if (lastWasMe) {
      // si el autor fui yo
      author = Translations.of(context).text("you"); //Muestra "tu"
    } else {
      //si no, muestra el nombre del usuario
      this.user.getName();
    }
    String toShow = author + ': ' + message; //construye mensaje completo
    return Text(toShow);
  }
  /*
   * Pre:   ---
   * Post:  crea un widget que representa el título de la miniatura
   */

  Widget title(BuildContext context) {
    Widget b;
    if (closed) {
      //si la venta está cerrada
      b = new Row(children: <Widget>[
        buildTitle(context),
        Container(width: 100.0),
        Container(
          margin: EdgeInsets.only(top: 15.0),
          child: DecoratedBox(
            //incluir mensaje de cerrado
            decoration: BoxDecoration(color: Colors.pink),
            child: Container(
                margin: EdgeInsets.all(1.0),
                child: Text(
                  (isBuyer
                      ? Translations.of(context).text("chat_finished_buy")
                      : Translations.of(context).text("chat_finished_sell")),
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                )),
          ),
        )
      ]);
    } else {
      //si no, se construye el título sin cajita
      b = buildTitle(context);
    }
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          CircleAvatar(backgroundImage: NetworkImage(this.user.getPicture())),
      title: title(context),
      subtitle: Text(dateToFullString(this.lastTimeDate, context)),
      enabled: true,
      trailing: CircleAvatar(
          backgroundImage: NetworkImage(this
              .product
              .getImage())), //imagen del producto sobre el que se chatea
    );
  }
}
