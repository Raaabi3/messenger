import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../Models/Chat.dart';
import '../Models/Helpers/Message.dart';
import '../Models/RuleModel.dart';

class ChatController with ChangeNotifier {
  final TextEditingController textController = TextEditingController();
  bool typing = false;
  List<Chat> chats = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RuleModel currentRule = RuleModel(
  id: DateTime.now().toString(),  // <-- DateTime converted to string
  name: '',
  conditionType: 'Contains',
  conditionValue: '',
  actionType: 'Send Reply',
);

  final Box<RuleModel> _ruleBox = Hive.box<RuleModel>('rule_model_box');

  List<String> conditions = ['Contains', 'Does Not Contain', 'Budget', 'Time'];
  List<String> actions = ['Send Reply', 'Forward to Email', 'Do Nothing'];
  List<RuleModel> get rules => _ruleBox.values.toList();

  final Box<Chat> _chatBox = Hive.box<Chat>('chats');
  

  final Box _messageBox = Hive.box('messages');

  void loadChats() {
    chats = _chatBox.values.toList();
    notifyListeners();
  }

  Future<void> saveChat(Chat chat) async {
    await _chatBox.put(chat.username, chat);
    notifyListeners();
  }

  void addMessage(String chatId, Message message) {
    List<Message> chatMessages =
        (_messageBox.get(chatId, defaultValue: []) as List)
            .cast<Message>(); // Ensure correct type casting
    chatMessages.add(message);
    _messageBox.put(chatId, chatMessages);
    notifyListeners();
  }

  List<Message> getMessages(String chatId) {
    return (_messageBox.get(chatId, defaultValue: []) as List).cast<Message>();
  }

  void setTyping(bool isTyping) {
    typing = isTyping;
    notifyListeners();
  }

  void clearText() {
    textController.clear();
    notifyListeners();
  }

  void addRule(RuleModel rule) {
    _ruleBox.put(rule.id, rule); // Save rule to Hive
    notifyListeners();
  }

  // Update a rule in Hive
  void updateRule(RuleModel rule) {
    _ruleBox.put(rule.id, rule); // Update rule in Hive
    notifyListeners();
  }

  // Delete a rule from Hive
  void deleteRule(String id) {
    _ruleBox.delete(id); // Delete rule from Hive
    notifyListeners();
  }

  void saveRule() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (_ruleBox.containsKey(currentRule.id)) {
        updateRule(currentRule);
      } else {
        addRule(currentRule);
      }
    }
  }
}
