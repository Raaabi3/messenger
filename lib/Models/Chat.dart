import 'Conversation.dart';

class Chat {
  String? image;
  String? username;
  String? lastmessage;
  bool? status;
  bool? received;
  bool? read;
  DateTime? time;
  List<Conversation>? conversations;
  DateTime? lastSeenTime;
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