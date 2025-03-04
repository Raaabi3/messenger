import 'package:flutter/material.dart';
import 'package:hive/hive.dart'; // Import Hive
import '../Models/Chat.dart';
import 'package:intl/intl.dart';
import '../Models/ChatMessage.dart';

class HomescreenController with ChangeNotifier {
  bool _addconv = false;
  bool get addconv => _addconv;

  List<Chat> chats = [];

  final Box<Chat> _chatBox = Hive.box<Chat>('chats'); // Add this line

  void setconv() {
    _addconv = !_addconv;
    notifyListeners();
  }

  void loadChats() {
    chats = _chatBox.values.toList();
    print("Chats loaded: ${chats.length}");
    for (var chat in chats) {
      print("Chat: ${chat.username}");
    }
    notifyListeners();
  }

  void addChat(Chat chat) {
    chats.add(chat);
    _chatBox.put(chat.username, chat); // Save chat in Hive
    notifyListeners();
  }

  void addChats(List<Chat> newChats) {
    chats.addAll(newChats);
    for (var chat in newChats) {
      _chatBox.put(chat.username, chat); // Save in Hive
    }
    notifyListeners();
  }

  void updateConversation(int chatIndex, ChatMessage newMessage) {
    if (chatIndex >= 0 && chatIndex < chats.length) {
      chats[chatIndex].conversations?.add(newMessage);
      _chatBox.put(chats[chatIndex].username, chats[chatIndex]); // Save update
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
