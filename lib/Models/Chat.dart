import 'package:hive/hive.dart';
import 'ChatMessage.dart';

part 'Chat.g.dart'; // This file will be generated automatically

@HiveType(typeId: 2)
class Chat {
  @HiveField(0)
  String? image;

  @HiveField(1)
  String? username;

  @HiveField(2)
  String? lastmessage;

  @HiveField(3)
  bool? status;

  @HiveField(4)
  bool? received;

  @HiveField(5)
  bool? read;

  @HiveField(6)
  DateTime? time;

  @HiveField(7)
  List<ChatMessage>? conversations;

  @HiveField(8)
  DateTime? lastSeenTime;

  @HiveField(9)
  bool mute = false;

  Chat({
    this.image,
    this.username,
    this.lastmessage,
    this.status,
    this.received,
    this.read,
    this.time,
    this.conversations,
    this.lastSeenTime,
  });
}
