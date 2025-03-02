import 'package:hive/hive.dart';

part 'ChatMessage.g.dart'; // This file will be generated automatically

@HiveType(typeId: 1)
class ChatMessage {
  @HiveField(0)
  String? sentMessage;

  @HiveField(1)
  String? receivedMessage;

  @HiveField(2)
  DateTime? sentMessageTime;

  @HiveField(3)
  DateTime? receivedMessageTime;

  ChatMessage({
    this.sentMessage,
    this.receivedMessage,
    this.sentMessageTime,
    this.receivedMessageTime,
  });
}
