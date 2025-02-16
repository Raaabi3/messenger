import 'package:flutter/material.dart';

class ChatController with ChangeNotifier {
  bool _typing = false;
  final TextEditingController _textController = TextEditingController();

  bool get typing => _typing;
  TextEditingController get textController => _textController;

  void setTyping(bool value) {
    _typing = value;
    notifyListeners(); 
  }

  void clearText() {
    _textController.clear();
    notifyListeners();
  }
}