import 'package:flutter/material.dart';
import 'package:messenger/Models/Conversation.dart';

import '../Models/Chat.dart';
import '../Models/Helpers/_MessageItem .dart';


class Chatscreen extends StatefulWidget {
  final Chat chat;

  const Chatscreen({super.key, required this.chat});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  List<Conversation> conversations = [
    Conversation()
      ..sentMessage = "Hey Sarah, are you on your way?"
      ..sentMessageTime = DateTime(2025, 2, 15, 14, 0)
      ..receivedMessage = "Yes, but I'm stuck in traffic. Running 15 mins late!"
      ..receivedMessageTime = DateTime(2025, 2, 15, 14, 10),
    Conversation()
      ..sentMessage = "No worries, take your time!"
      ..sentMessageTime = DateTime(2025, 2, 15, 14, 15),
    Conversation()
      ..sentMessage = "Hey Michael, did you finish the designs?"
      ..sentMessageTime = DateTime(2025, 2, 15, 12, 0)
      ..receivedMessage = "Yes, just sent them over. Let me know your thoughts!"
      ..receivedMessageTime = DateTime(2025, 2, 15, 12, 15),
    Conversation()
      ..sentMessage = "Hey Emma, are you free tomorrow for coffee?"
      ..sentMessageTime = DateTime(2025, 2, 14, 18, 30)
      ..receivedMessage = "Sure! 9am at Blue Bottle works for me."
      ..receivedMessageTime = DateTime(2025, 2, 14, 18, 45),
    Conversation()
      ..sentMessage = "Hey David, did my package arrive?"
      ..sentMessageTime = DateTime(2025, 2, 14, 9, 45)
      ..receivedMessage = "Yes, it was delivered just now!"
      ..receivedMessageTime = DateTime(2025, 2, 14, 10, 0),
  ];
String _formatTime(DateTime time) {
  return "${time.hour}:${time.minute.toString().padLeft(2, '0')}";
}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(children: [
              CircleAvatar(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.asset(
                    "assets/images/ProfilePic.jpeg",
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Positioned(
                  bottom: 0,
                  right: 0,
                  child: CircleAvatar(
                    radius: 7,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: Colors.green[400],
                      radius: 5,
                    ),
                  ))
            ]),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.username.toString(),
                    style: TextStyle(
                        fontSize: 15,
                        fontFamily: "SfProDisplay",
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Active",
                    style: TextStyle(
                        fontSize: 11,
                        fontFamily: "SfProDisplay",
                        color: Colors.grey),
                  ),
                ],
              ),
            ),
            Spacer(),
            IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: Icon(Icons.info_rounded))
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: conversations.length,
        itemBuilder: (context, index) {
          final sortedMessages = [
            if (conversations[index].sentMessageTime != null)
              MessageItem(
                text: conversations[index].sentMessage!,
                time: conversations[index].sentMessageTime!,
                isSent: true,
              ),
            if (conversations[index].receivedMessageTime != null)
              MessageItem(
                text: conversations[index].receivedMessage!,
                time: conversations[index].receivedMessageTime!,
                isSent: false,
              ),
          ]..sort((a, b) => a.time.compareTo(b.time));

          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: sortedMessages.map((message) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: message.isSent ? Colors.blue[100] : Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      message.text,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 4),
                    Text(
                      _formatTime(message.time),
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),



      bottomNavigationBar: Row(
        children: [
          IconButton(onPressed: () {}, icon: Icon(Icons.add_circle_rounded)),
          IconButton(onPressed: () {}, icon: Icon(Icons.camera_alt)),
          IconButton(onPressed: () {}, icon: Icon(Icons.photo_outlined)),
          IconButton(onPressed: () {}, icon: Icon(Icons.mic)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                    onPressed: () {}, icon: Icon(Icons.emoji_emotions)),
                hintText: 'Message',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontFamily: "SfProDisplay",
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          IconButton(
              onPressed: () {}, icon: Icon(Icons.thumb_up_off_alt_rounded)),
        ],
      ),
    );
  }
}
