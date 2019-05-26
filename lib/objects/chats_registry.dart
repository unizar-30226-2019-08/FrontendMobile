/*
 * FICHERO:     chat_registru.dart
 * DESCRIPCIÓN: clase Chat Registry
 * CREACIÓN:    15/05/2019
 */
import 'package:bookalo/objects/review.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:bookalo/objects/chat.dart';
import 'package:bookalo/objects/message.dart';

/*
 *  CLASE:        ChatRegistry
 *  DESCRIPCIÓN:  clase para la gestión centralizada de conversaciones de chat
 */

class ChatsRegistry extends Model {
  Map<String, List<Chat>> _chatMap;
  Map<String, bool> _chatEndReached;
  Map<int, bool> _messagesEndReached;
  Map<int, List<Message>> _messagesMap;

  ChatsRegistry() {
    _chatMap = {'buyers': [], 'sellers': []};
    _chatEndReached = {'buyers': false, 'sellers': false};
    _messagesEndReached = {};
    _messagesMap = {};
  }

  void setChatsEndReached(String kind, bool value) {
    _chatEndReached[kind] = value;
  }

  void setMessagesEndReached(int chatUID, bool value) {
    _messagesEndReached[chatUID] = value;
  }

  List<Chat> getChats(String kind) {
    return _chatMap[kind];
  }

  List<Chat> get getBuyersChat {
    return _chatMap['buyers'];
  }

  List<Chat> get getSellersChat {
    return _chatMap['sellers'];
  }

  bool getChatsEndReached(String kind) {
    return _chatEndReached[kind];
  }

  bool getMessagesEndReached(int chatID) {
    return _messagesEndReached[chatID];
  }

  void addChats(String kind, List<Chat> newChats) {
    newChats.forEach((newChat) {
      var oldChat =
          _chatMap[kind].where((oldChat) => oldChat.getUID == newChat.getUID);
      if (oldChat.length == 0) {
        _chatMap[kind].insert(0, newChat);
        _messagesMap[newChat.getUID] = [];
        _messagesEndReached[newChat.getUID] = false;
      } else {
        int index = _chatMap[kind].indexOf(oldChat.first);
        Chat updatingChat = oldChat.first;
        updatingChat.setLastMessage(newChat.getLastMessage);
        updatingChat.setPendingMessages(newChat.pendingMessages);
        _chatMap[kind].replaceRange(index, index + 1, [updatingChat]);
      }
    });
    sortChats(kind);
    notifyListeners();
  }

  void sortChats(String kind) {
    _chatMap[kind].sort((c1, c2) {
      /*  venta = 0 si ambos son de misma condicion
       *        = 3 si solo c1 en venta y con mensajes -> 1
       *        = 1 si ambos en estan en venta o ninguno y solo c1 con mensajes -> 1
       *        = 2 si c1 en venta y c2 no -> 1
       *        = -1 si ambos en venta o ninguno y solo c2 con mensajes ->1
       *        = -2 si c2 en venta y c1 no -> -1
       *        = -3 si solo c2 en venta y cn mensajes -> 1
      */
      int venta = 0;
      if (c1.checkForSale()) {
        venta += 2;
      }
      if (c2.checkForSale()) {
        venta -= 2;
      }
      if (c1.lastMessage != null) {
        venta += 1;
      }
      if (c2.lastMessage != null) {
        venta -= 1;
      }
      if (venta == 0) {
        if (c1.lastMessage == null) {
          //ninguno tienen mensajes -> iguales
          return 0;
        }
        return c2.getLastMessage.getTimestamp
            .compareTo(c1.getLastMessage.getTimestamp);
      } else if (venta < 0) {
        return 1;
      } else {
        return -1;
      }
    });
  }

  List<Message> getMessages(int chatUID) {
    return _messagesMap[chatUID];
  }

  void addMessage(String kind, Chat chat, Message message) {
    chat.setLastMessage(message);
    addChats(kind, [chat]);
    _messagesMap[chat.getUID].insert(0, message);
    notifyListeners();
  }

  void appendMessage(String kind, Chat chat, List<Message> messages) {
    _messagesMap[chat.getUID].addAll(messages);
    notifyListeners();
  }

  void removePending(String kind, Chat chat) {
    _chatMap[kind].singleWhere((c) => c.getUID == chat.getUID).pendingMessages =
        0;
    notifyListeners();
  }

  bool areTherePending() {
    _chatMap.values.forEach((list) {
      list.forEach((chat) {
        if (chat.numberOfPending > 0) {
          return true;
        }
      });
    });
    return false;
  }

  void setReview(Review review, int chatUID, String kind) {
    if (kind == 'buyers') {
      _messagesMap[chatUID]
          .singleWhere((message) => message.itsReview)
          .sellerReview = review;
    } else {
      _messagesMap[chatUID]
          .singleWhere((message) => message.itsReview)
          .buyerReview = review;
    }
    notifyListeners();
  }

  void removeChat(int chatUID, String kind) {
    _chatMap[kind].removeWhere((c) => c.getUID == chatUID);
    notifyListeners();
  }

  void closeChat(int chatUID, String kind){
    _chatMap[kind].singleWhere((c) => c.getUID == chatUID).product.isForSale = false;
    sortChats(kind);
    notifyListeners();
  }

  void markMessageAsSent(int chatUID){
    _messagesMap[chatUID].first.markAsSent();
    notifyListeners();
  }
}
