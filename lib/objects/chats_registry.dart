/*
 * FICHERO:     chat_registru.dart
 * DESCRIPCIÓN: clase Chat Registry
 * CREACIÓN:    15/05/2019
 */
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
    _chatMap = {'buyers' : [], 'sellers' : []};
    _chatEndReached = {'buyers' : false, 'sellers' : false};
    _messagesEndReached = {};
    _messagesMap = {};
  }

  void setChatsEndReached(String kind, bool value){
    _chatEndReached[kind] = value;
  }

  void setMessagesEndReached(int chatUID, bool value){
    _messagesEndReached[chatUID] = value;
  }

  List<Chat> getChats(String kind){
    return _chatMap[kind];
  }

  List<Chat> get getBuyersChat {
    return _chatMap['buyers'];
  }

  List<Chat> get getSellersChat {
    return _chatMap['sellers'];
  }

  bool getChatsEndReached(String kind){
    return _chatEndReached[kind];
  }

  bool getMessagesEndReached(int chatID){
    return _messagesEndReached[chatID];
  }

  void addChats(String kind, List<Chat> newChats){
    newChats.forEach((newChat){
      if(_chatMap[kind].where((oldChat) => oldChat.getUID == newChat.getUID).length == 0){
        _chatMap[kind].insert(0, newChat);
        _messagesMap[newChat.getUID] = [];
        _messagesEndReached[newChat.getUID] = false;
      }
    });
    notifyListeners();
  }

  List<Message> getMessages(int chatUID){
    return _messagesMap[chatUID];
  }

  void addMessage(String kind, Chat chat, List<Message> messages) {
    addChats(kind, [chat]);
    messages.forEach((message){
      _messagesMap[chat.getUID].insert(0, message);
    });
    notifyListeners();
  }
}
