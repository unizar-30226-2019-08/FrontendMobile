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
    _chatMap[kind].sort((c1, c2){
      if(c1.lastMessage != null && c2.lastMessage != null){
        return c2.getLastMessage.getTimestamp.compareTo(c1.getLastMessage.getTimestamp);
      }else{
        return -1;
      }
    });
    notifyListeners();
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

  void removePending(String kind, Chat chat){
    _chatMap[kind].singleWhere((c) => c.getUID == chat.getUID).pendingMessages = 0;
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

  void setReview(Review review, int chatUID){
    _messagesMap[chatUID].singleWhere((message) => message.itsReview).review = review;
    notifyListeners();
  }
}
