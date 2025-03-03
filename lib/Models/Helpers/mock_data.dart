import 'dart:math';

import 'package:flutter/material.dart';
import 'package:messenger/Models/Helpers/Message.dart';

import '../Chat.dart';
import '../ChatMessage.dart';

List<Chat> mockChats = [
  Chat(
    image: "assets/images/1.jpg",
    username: 'Aya Zitouna',
    lastmessage: 'Hey, are we still on for dinner tonight? 🍝',
    lastSeenTime: DateTime.now().subtract(Duration(minutes: Random().nextInt(100))),
    status: true,
    received: true,
    read: false,
    time: DateTime(2025, 2, 15, 14, 30),
    conversations: [
      ChatMessage (messages: []
      ),
    ],
  ),
  Chat(
    image: "assets/images/2.jpg",
    username: 'Salima Azzi',
    lastmessage: 'Can you send me the notes from the meeting? 📝',
    lastSeenTime: DateTime.now().subtract(Duration(minutes: Random().nextInt(100))),
    status: true,
    received: true,
    read: true,
    time: DateTime(2025, 2, 15, 14, 30),
    conversations: [
      ChatMessage (messages: []
      ),
    ],
  ),
  Chat(
    image: "assets/images/3.jpg",
    username: 'Angel Garvin',
    lastmessage: 'Did you watch the new episode last night? 🍿',
    lastSeenTime: DateTime.now().subtract(Duration(minutes: Random().nextInt(100))),
    status: false,
    received: true,
    read: true,
    time: DateTime(2025, 2, 15, 14, 30),
    conversations: [
      ChatMessage (messages: []
      ),
    ],
  ),
  Chat(
    image: "assets/images/4.jpg",
    username: 'Islam Mansouri',
    lastmessage: 'Let’s catch up this weekend! 🏀',
    lastSeenTime: DateTime.now().subtract(Duration(minutes: Random().nextInt(100))),
    status: true,
    received: false,
    read: false,
    time: DateTime(2025, 2, 15, 14, 30),
    conversations: [
      ChatMessage (messages: []
      ),
    ],
  ),
];