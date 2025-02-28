import 'package:flutter/material.dart';
import '../Models/Chat.dart';
import '../Models/DatabaseHelper.dart';

class ChatController with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  bool typing = false;

  final DatabaseHelper _databaseHelper = DatabaseHelper();

  List<Chat> chats = [];

  Future<void> loadChats() async {
    chats = await _databaseHelper.loadChats();
    notifyListeners();
  }

  Future<void> addChat(Chat chat) async {
    await _databaseHelper.saveChat(chat);
    chats.add(chat);
    notifyListeners();
  }

  void setTyping(bool isTyping) {
    typing = isTyping;
    notifyListeners();
  }

  void clearText() {
    textController.clear();
    notifyListeners();
  }
}