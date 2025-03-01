import 'package:hive/hive.dart';

part 'Message.g.dart'; // This file will be generated automatically

@HiveType(typeId: 0) // Unique ID for the adapter
class Message {
  @HiveField(0)
  final String text;

  @HiveField(1)
  final DateTime time;

  @HiveField(2)
  final bool isSent;

  Message({required this.text, required this.time, required this.isSent});
}
