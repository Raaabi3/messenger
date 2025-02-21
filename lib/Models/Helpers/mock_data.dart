import 'dart:math';

import '../Chat.dart';
import '../Conversation.dart';

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
      Conversation(
        sentMessage: "Hey Aya, are we still on for dinner tonight?",
        sentMessageTime: DateTime(2025, 2, 15, 14, 0),
        receivedMessage: "Yes, absolutely! I’ll be there by 7 PM.",
        receivedMessageTime: DateTime(2025, 2, 15, 14, 10),
      ),
      Conversation(
        sentMessage: "Great! I’ll meet you at the Italian place.",
        sentMessageTime: DateTime(2025, 2, 15, 14, 15),
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
      Conversation(
        sentMessage: "Hey Salima, can you send me the notes from the meeting?",
        sentMessageTime: DateTime(2025, 2, 15, 14, 0),
        receivedMessage: "Sure, I’ll email them to you in a few minutes.",
        receivedMessageTime: DateTime(2025, 2, 15, 14, 10),
      ),
      Conversation(
        sentMessage: "Thanks a lot! I really appreciate it.",
        sentMessageTime: DateTime(2025, 2, 15, 14, 15),
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
      Conversation(
        sentMessage: "Hey Angel, did you watch the new episode last night?",
        sentMessageTime: DateTime(2025, 2, 15, 14, 0),
        receivedMessage: "Yes! It was amazing. What did you think of the ending?",
        receivedMessageTime: DateTime(2025, 2, 15, 14, 10),
      ),
      Conversation(
        sentMessage: "I was shocked! Didn’t see that twist coming.",
        sentMessageTime: DateTime(2025, 2, 15, 14, 15),
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
      Conversation(
        sentMessage: "Hey Islam, let’s catch up this weekend!",
        sentMessageTime: DateTime(2025, 2, 15, 14, 0),
        receivedMessage: "Sounds good! How about a game of basketball?",
        receivedMessageTime: DateTime(2025, 2, 15, 14, 10),
      ),
      Conversation(
        sentMessage: "Perfect! Let’s meet at the court at 10 AM.",
        sentMessageTime: DateTime(2025, 2, 15, 14, 15),
      ),
    ],
  ),
];