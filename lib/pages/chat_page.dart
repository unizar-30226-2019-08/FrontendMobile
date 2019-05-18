/*
 * FICHERO:     MyChats.dart
 * DESCRIPCIÓN: clases relativas al la página de chats
 * CREACIÓN:    15/03/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/widgets/navbars/chat_navbar.dart';
import 'package:bookalo/widgets/bubble_chat.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/objects/message.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/translations.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';

/*
 *  CLASE:        Chat
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la página de un chat concreto
 */
class ChatPage extends StatefulWidget {
  final Chat chat;

  ChatPage({Key key, this.chat}) : super(key: key);

  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  bool closed = false;
  bool _endReached = false;
  bool _isLoading = false;

  TextEditingController _textController;

  void fetchMessages(ChatsRegistry registry, int pageSize) async {
    if (!_endReached) {
      if (!_isLoading) {
        _isLoading = true;
        parseMessages(widget.chat.getUID, pageSize, 10).then((newMessages) {
          _isLoading = false;
          registry.addMessage(widget.chat.imBuyer ? 'sellers' : 'buyers',
              widget.chat, newMessages);
          if (newMessages.length == 0) {
            _endReached = true;
          }
        }).catchError((e) {
          print(e);
        });
      }
    }
  }

  void setClosed(BuildContext context) => setState(() => closed = true);

  void _handleSumbit(String text) {
    _textController.clear();
    sendMessage(widget.chat.getUID, text);
    ScopedModel.of<ChatsRegistry>(context).addMessage(
        widget.chat.imBuyer ? 'sellers' : 'buyers',
        widget.chat,
        [Message(text, DateTime.now(), true)]);
  }

  @override
  void initState() {
    super.initState();
    fetchMessages(
        ScopedModel.of<ChatsRegistry>(context),
        ScopedModel.of<ChatsRegistry>(context)
            .getMessages(widget.chat.getUID)
            .length);
    _textController = TextEditingController();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: ChatNavbar(
        preferredSize: Size.fromHeight(height / 10),
        interest: widget.chat.imBuyer ? Interest.offers : Interest.buys,
        user: widget.chat.getOtherUser,
        product: widget.chat.product,
      ),
      body: Column(children: <Widget>[
        (!widget.chat.checkImBuyer
        ? RaisedButton(
          color: Colors.pink,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          child: Text(
            Translations.of(context).text("close_chat"),
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          onPressed: () {
            setClosed(context);
          },
        )
        : Container()),
        Container(height: 10),
        ScopedModelDescendant<ChatsRegistry>(
            builder: (context, child, registry) {
          return Expanded(
              child: ListView.builder(
            reverse: true,
            itemBuilder: (context, position) {
              int length = ScopedModel.of<ChatsRegistry>(context)
                  .getMessages(widget.chat.getUID)
                  .length;
              if (position < length) {
                Message currentMessage =
                    registry.getMessages(widget.chat.getUID)[position];
                return Bubble(
                  message: currentMessage,
                  user: currentMessage.itsMe
                      ? widget.chat.getMe
                      : widget.chat.getOtherUser,
                );
              } else if (position == length && !_endReached) {
                fetchMessages(registry, length);
                return Container(
                    margin: EdgeInsets.symmetric(vertical: 50.0),
                    child: BookaloProgressIndicator());
              } else {
                return null;
              }
            },
          ));
        }),
        Container(height: 10),
        Material(
          elevation: 30,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(5.0),
                width: width / 1.2,
                child: TextField(
                  textInputAction: TextInputAction.send,
                  controller: _textController,
                  onSubmitted: (text) {
                    _handleSumbit(text);
                  },
                  decoration: InputDecoration(
                      hintText: Translations.of(context).text("message_hint")),
                  autofocus: true,
                  keyboardType: TextInputType.multiline,
                  maxLines: 1,
                ),
              ),
              IconButton(
                icon: Icon(Icons.send, size: 30.0, color: Colors.pink),
                onPressed: () {
                  _handleSumbit(_textController.text);
                },
              )
            ],
          ),
        )
      ]),
    );
  }
}
