import 'package:flutter/material.dart';
import '../Models/Chat.dart';
import 'package:intl/intl.dart';

import '../Models/ChatMessage.dart';

class HomescreenController with ChangeNotifier {
  bool _addconv = false;
  bool get addconv => _addconv;

  List<Chat> chats = [];
  List<Chat> get _chats => chats;

  void setconv() {
    _addconv = !_addconv;
    notifyListeners();
  }

  // Method to add a single chat
  void addChat(Chat chat) {
    _chats.add(chat);
    notifyListeners();
  }

  void addChats(List<Chat> newChats) {
    _chats.addAll(newChats);
    notifyListeners();
  }

  void updateConversation(int chatIndex, ChatMessage newMessage) {
     if (chatIndex >= 0 && chatIndex < chats.length) {
      chats[chatIndex].conversations?.add(newMessage);
      notifyListeners(); 
    }
  }

  String formatTime(DateTime time) {
    DateTime now = DateTime.now();
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      return DateFormat('h:mm a').format(time);
    } else {
      return DateFormat('EEE').format(time);
    }
  }
}