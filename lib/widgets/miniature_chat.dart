/*
 * FICHERO:     miniature_chat.dart
 * DESCRIPCIÓN: clases relativas a la  miniatura de un chat
 * CREACIÓN:    14/03/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/utils/dates_utils.dart';
import 'package:bookalo/objects/chat.dart';
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
    if (chat.lastMessage != null) {
      String message;
      if(chat.lastMessage.itsReview){
        message = Translations.of(context).text("rate_user", params: [chat.getOtherUser.getName()]);
      }else{
        message = chat.lastMessage.body;
      }
      if (message.length > 30) {
        message = message.substring(0, 30) + '...';
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message,
            style: TextStyle(
                fontSize: 16,
                fontWeight: chat.numberOfPending > 0
                    ? FontWeight.bold
                    : FontWeight.w400),
          ),
          Text(
            dateToFullString(chat.lastMessage.getTimestamp, context),
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
              ? Container(width: 0)
              : Container(
                  margin: EdgeInsets.only(top: 15.0),
                  child: DecoratedBox(
                    decoration: BoxDecoration(color: Colors.pink),
                    child: Container(
                        margin: EdgeInsets.all(1.0),
                        child: Text(
                          Translations.of(context).text("chat_finished"),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.white),
                        )),
                  ),
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
      trailing: chat.numberOfPending > 0
          ? Stack(
              alignment: Alignment.center,
              children: <Widget>[
                CircleAvatar(
                    backgroundImage:
                        NetworkImage(chat.getProduct.getImages()[0])),
                ClipOval(
                  child: Container(
                    color: Colors.pink.withOpacity(0.7),
                    height: 30.0, // height of the button
                    width: 30.0, // width of the button
                    child: Center(
                      child: Text(
                          chat.numberOfPending > 9
                              ? '+9'
                              : chat.numberOfPending.toString(),
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500)),
                    ),
                  ),
                )
              ],
            )
          : CircleAvatar(
              backgroundImage: NetworkImage(chat.getProduct.getImages()[0]),
            ),
      onTap: () {
        ScopedModel.of<ChatsRegistry>(context).removePending(chat.imBuyer ? 'sellers' : 'buyers', chat);
        //TODO: borrado de pendientes en HTTP
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
