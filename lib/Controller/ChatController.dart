import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import '../Models/Chat.dart';
import '../Models/ChatMessage.dart';
import '../Models/Helpers/Message.dart';
import '../Models/RuleModel.dart';
import 'HomeController.dart';

class ChatController with ChangeNotifier {
  final HomescreenController homescreenController; 
  final TextEditingController textController = TextEditingController();
  bool typing = false;
  List<Chat> chats = [];
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RuleModel currentRule = RuleModel(
    id: DateTime.now().toString(), // <-- DateTime converted to string
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

  ChatController({required this.homescreenController});

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
            .cast<Message>(); 
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
    if (rule.conditionType == 'Time' && rule.conditionValue.isNotEmpty) {
      final parts = rule.conditionValue.split(':');
      rule = rule.copyWith(
        conditionTime: TimeOfDay(
          hour: int.parse(parts[0]),
          minute: int.parse(parts[1]),
        ),
      );
    }
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

  // Auto-reply logic
  void handleIncomingMessage(String message, String chatId) {
    for (final rule in rules) {
      if (_matchesRule(message, rule)) {
        _applyRuleAction(rule, chatId);
        break; // Stop after the first matching rule
      }
    }
  }

  // Check if the message matches the rule's condition
  bool _matchesRule(String message, RuleModel rule) {
    switch (rule.conditionType) {
      case 'Contains':
        return message.contains(rule.conditionValue);
      case 'Does Not Contain':
        return !message.contains(rule.conditionValue);
      case 'Budget':
        // Example: Check if the message contains a number less than or equal to the budget
        final budget = double.tryParse(rule.conditionValue);
        if (budget != null) {
          final numbersInMessage = _extractNumbers(message);
          return numbersInMessage.any((number) => number! <= budget);
        }
        return false;
      case 'Time':
        if (rule.conditionTime == null) return false;
        final now = TimeOfDay.now();
        return now.hour > rule.conditionTime!.hour ||
            (now.hour == rule.conditionTime!.hour &&
                now.minute >= rule.conditionTime!.minute);
      default:
        return false;
    }
  }

  // Extract numbers from a message
  List<double?> _extractNumbers(String message) {
    final regex = RegExp(r'\d+(\.\d+)?');
    return regex
        .allMatches(message)
        .map((match) => double.tryParse(match.group(0)?.toString() ?? ''))
        .toList();
  }

  // Apply the rule's action
  void _applyRuleAction(RuleModel rule, String chatId) {
  final replyMessage = rule.replyMessage;
  if (replyMessage.isEmpty) return;

  void sendReply() {
    final message = Message(
      text: replyMessage,
      isSent: false,
      time: DateTime.now().add(rule.delayDuration ?? Duration.zero),
    );

    // Add the message to Hive
    addMessage(chatId, message);

    // Find the chat index in HomescreenController
    final chatIndex = homescreenController.chats.indexWhere(
      (chat) => chat.username == chatId,
    );

    if (chatIndex != -1) {
      // Update the conversation in HomescreenController
      homescreenController.updateConversation(
        chatIndex,
        ChatMessage(messages: [message]),
      );
    }

    notifyListeners();
  }

  if (rule.enableDelay && rule.delayDuration != null) {
    Future.delayed(rule.delayDuration!, sendReply);
  } else {
    sendReply();
  }
}
}
