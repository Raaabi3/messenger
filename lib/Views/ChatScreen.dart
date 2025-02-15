import 'package:flutter/material.dart';
import '../Models/Conversation.dart';
import '../Models/Chat.dart';
import '../Models/Helpers/MessageItem .dart';
import '../Widgets/MessageBubble.dart';  

class Chatscreen extends StatefulWidget {
  final Chat chat;

  const Chatscreen({super.key, required this.chat});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  List<MessageItem> messages = [];

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  void _loadMessages() {
    final conversations = [
      Conversation()
        ..sentMessage = "Hey Sarah, are you on your way?"
        ..sentMessageTime = DateTime(2025, 2, 15, 14, 0)
        ..receivedMessage =
            "Yes, but I'm stuck in traffic. Running 15 mins late!"
        ..receivedMessageTime = DateTime(2025, 2, 15, 14, 10),
      Conversation()
        ..sentMessage = "No worries, take your time!"
        ..sentMessageTime = DateTime(2025, 2, 15, 14, 15),
      Conversation()
        ..sentMessage = "Hey Michael, did you finish the designs?"
        ..sentMessageTime = DateTime(2025, 2, 15, 12, 0)
        ..receivedMessage =
            "Yes, just sent them over. Let me know your thoughts!"
        ..receivedMessageTime = DateTime(2025, 2, 15, 12, 15),
      Conversation()
        ..sentMessage = "blablabla?"
        ..sentMessageTime = DateTime(2025, 2, 15, 12, 1)
        ..receivedMessage = "Yes, blablabla"
        ..receivedMessageTime = DateTime(2025, 2, 15, 12, 16),
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


    for (var conversation in conversations) {
      if (conversation.sentMessageTime != null) {
        messages.add(MessageItem(
          text: conversation.sentMessage!,
          time: conversation.sentMessageTime!,
          isSent: true,
        ));
      }
      if (conversation.receivedMessageTime != null) {
        messages.add(MessageItem(
          text: conversation.receivedMessage!,
          time: conversation.receivedMessageTime!,
          isSent: false,
        ));
      }
    }

    messages.sort((a, b) => a.time.compareTo(b.time));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
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
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.chat.username.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      fontFamily: "SfProDisplay",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    "Active",
                    style: TextStyle(
                      fontSize: 11,
                      fontFamily: "SfProDisplay",
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.info_rounded)),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          return MessageBubble(message: messages[index]);
        },
      ),
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {}, icon: const Icon(Icons.add_circle_rounded)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.camera_alt)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.photo_outlined)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.mic)),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.emoji_emotions),
                ),
                hintText: 'Message',
                hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontFamily: "SfProDisplay",
                ),
                filled: true,
                fillColor: Colors.grey[100],
              ),
            ),
          ),
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.thumb_up_off_alt_rounded)),
        ],
      ),
    );
  }
}
