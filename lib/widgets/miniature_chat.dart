import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/objects/user.dart';
import 'package:bookalo/objects/product.dart';
import 'package:bookalo/translations.dart';

class MiniatureChat extends StatelessWidget {
  final User user; //Usuario con el que se chatea
  final Product product; //Producto sobre el que trata el chat
  final bool lastWasMe; //vale true si el usuario es el autor del ultimo mensaje
  final String lastMessage; //ultimo mensaje enviado en el chat
  final bool closed; //vale true si la transacción está cerrada
  final DateTime lastTimeDate; //indica la fecha de la última conexión
  //final EdgeInsetsGeometry padding;
  // final Color color;
  MiniatureChat(
      {Key key,
      this.user,
      this.product,
      this.lastWasMe,
      this.lastMessage,
      this.closed,
      this.lastTimeDate})
      : super(key: key);

  /*
   * Pre:  ---
   * Post: construye el título de la miniatura con último mensaje y su autor
   */
  Text buildTitle(BuildContext context) {
    String message = "";
    String author = "";
    if (this.lastMessage.length > 10) {
      message = this.lastMessage.substring(1, 10) + "...";
    } else {
      message = this.lastMessage;
    }

    if (lastWasMe) {
      author = Translations.of(context).text("you");
    } else {
      this.user.getName();
    }
    String aMostrar = author + ': ' + message;
    return Text(aMostrar);
  }

  Widget title(BuildContext context) {
    Widget b;
    if (closed) {
      b = new Row(children: <Widget>[
        buildTitle(context),
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.pink),
          child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Text(
                'Cerrado',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
              )),
        )
      ]);
    } else {
      b = buildTitle(context);
    }
    return b;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage(this.user.getImagenPerfil())),
      title: title(context),
      subtitle: Text(dateToFullString(this.lastTimeDate, context)),
      isThreeLine: true,
      enabled: true,
      trailing:
          CircleAvatar(backgroundImage: NetworkImage(this.product.getImage())),
      dense: true,
    );
  }
}
