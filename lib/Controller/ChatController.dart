import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/Helpers/Message.dart';

class ChatController with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  bool typing = false;

  final Box<Message> _messageBox = Hive.box<Message>('messages');

  void addMessage(Message message) {
    _messageBox.add(message);
    notifyListeners();
  }

  List<Message> getMessages() {
    return _messageBox.values.toList();
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
