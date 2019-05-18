/*
 * FICHERO:     miniature_chat.dart
 * DESCRIPCIÓN: clases relativas a la  miniatura de un chat
 * CREACIÓN:    14/03/2019
 */

import 'package:flutter/widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:flutter/material.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/pages/chat_page.dart';

/*
 *  CLASE:        MiniatureChat
 *  DESCRIPCIÓN:  widget para mostrar la información de un chat aún vigente
 */

class MiniatureChat extends StatelessWidget {
  final Chat chat;
  MiniatureChat({Key key, this.chat}) : super(key: key);

  /*
   * Pre:  ---
   * Post: construye el título de la miniatura con el último mensaje y su autor
   */
  Widget buildSubtitle(BuildContext context) {
    var messagesList =
        ScopedModel.of<ChatsRegistry>(context).getMessages(chat.uid);
    if (messagesList != null && messagesList.length > 0) {
      String message = "   ";
      message = messagesList.first.body;
      if (message.length > 30) {
        message = message.substring(0, 30) + '...';
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(fontSize: 16),
          ),
          Text(
            dateToFullString(messagesList.first.timestamp, context),
            style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic),
          )
        ],
      );
    } else {
      return Text(Translations.of(context).text("not_yet_chat"));
    }
  }
  /*
   * Pre:   ---
   * Post:  crea un widget que representa el título de la miniatura
   */

  Widget buildTitle(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            chat.getOtherUser.getName(),
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 20.0),
          ),
          (chat.getProduct.checkfForSale()
          ? Container()
          : DecoratedBox(
            decoration: BoxDecoration(color: Colors.pink),
            child: Container(
                margin: EdgeInsets.all(1.0),
                child: Text(
                  (chat.checkImBuyer
                      ? Translations.of(context).text("chat_finished_sell")
                      : Translations.of(context).text("chat_finished_buy")),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                )),
          )),
        ]);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
          backgroundImage: NetworkImage(chat.getOtherUser.getPicture())),
      title: buildTitle(context),
      subtitle: buildSubtitle(context),
      isThreeLine: true,
      enabled: true,
      trailing: CircleAvatar(
          backgroundImage: NetworkImage(chat.getProduct.getImages()[0])),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ChatPage(
                      chat: chat,
                    )));
      },
    );
  }
}
