/*
 * FICHERO:     chats_list.dart
 * DESCRIPCIÓN: clases relativas a la pestaña de chats de compra
 * CREACIÓN:    20/04/2019
 */
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/chats_registry.dart';
import 'package:bookalo/widgets/animations/bookalo_progress.dart';
import 'package:bookalo/utils/http_utils.dart';
import 'package:bookalo/widgets/miniature_chat.dart';
import 'package:bookalo/widgets/empty_list.dart';

/*
 *  CLASE:        ChatsList
 *  DESCRIPCIÓN:  widget para el cuerpo principal de la pestaña
 *                de chats de compra. Contiene una lista con las miniaturas
 *                de los chats iniciados con vendedores
 *               
 */
class ChatsList extends StatefulWidget {
  final bool imBuyer;
  ChatsList({Key key, this.imBuyer}) : super(key: key);

  @override
  State<ChatsList> createState() {
    return _ChatsListState();
  }
}

class _ChatsListState extends State<ChatsList> {
  bool _isLoading = false;
  bool _endReached = false;
  bool _noFirstFetch = true;

  void fetchChats(ChatsRegistry registry, int pageSize) async {
    if (!_endReached) {
      if (!_isLoading) {
        _isLoading = true;
        parseChats(widget.imBuyer, pageSize, 10).then((newChats) {
          _isLoading = false;
          if (newChats.length == 0) {
            _endReached = true;
          }
          registry.addChats(widget.imBuyer ? 'sellers' : 'buyers', newChats);
          setState(() => _noFirstFetch = false);
        }).catchError((e) {
          print(e);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    fetchChats(ScopedModel.of<ChatsRegistry>(context), 0);
  }

  Widget build(BuildContext context) {
    return ScopedModelDescendant<ChatsRegistry>(
        builder: (context, child, chatsRegistry) {
      if (chatsRegistry.getChats(widget.imBuyer ? 'sellers' : 'buyers').length >
          0) {
        return ListView.builder(
          itemBuilder: (context, position) {
            if (position <
                chatsRegistry
                    .getChats(widget.imBuyer ? 'sellers' : 'buyers')
                    .length) {
              return MiniatureChat(
                  chat: chatsRegistry.getChats(
                      widget.imBuyer ? 'sellers' : 'buyers')[position]);
            } else if (position ==
                    chatsRegistry
                        .getChats(widget.imBuyer ? 'sellers' : 'buyers')
                        .length &&
                !_endReached) {
              fetchChats(
                chatsRegistry,
                chatsRegistry
                    .getChats(widget.imBuyer ? 'sellers' : 'buyers')
                    .length,
              );
              return Container(
                  margin: EdgeInsets.symmetric(vertical: 50.0),
                  child: BookaloProgressIndicator());
            } else {
              return null;
            }
          },
        );
      } else {
        if (_noFirstFetch) {
          return BookaloProgressIndicator();
        } else {
          return EmptyList(
            iconData: Icons.chat_bubble_outline,
            textKey: widget.imBuyer ? 'no_sellers_yet' : 'no_buyers_yet',
          );
        }
      }
    });
  }
}
