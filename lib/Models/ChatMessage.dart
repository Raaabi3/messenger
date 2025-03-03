import 'package:hive/hive.dart';
import 'Helpers/Message.dart';

part 'ChatMessage.g.dart'; // This file will be generated automatically

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  List<Message> messages; // List of messages in the conversation

  ChatMessage({required this.messages});
}