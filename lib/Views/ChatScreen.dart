import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:messenger/Views/ChatProfileScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../Controller/ChatController.dart';
import '../Controller/HomeController.dart';
import '../Models/Chat.dart';
import '../Models/ChatMessage.dart';
import '../Models/Helpers/Message.dart';
import '../Widgets/AutoReplyDialog.dart';
import '../Widgets/MessageBubble.dart';

class Chatscreen extends StatefulWidget {
  final Chat chat;
  final int chatIndex;
  final HomescreenController controller;

  const Chatscreen({super.key, required this.chat, required this.controller, required this.chatIndex});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();
  int _prevMessageCount = 0; // Track previous message count


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  List<Message> _loadMessages(ChatController chatController) {
    final messages = chatController.getMessages(widget.chat.username!);
    messages.sort((a, b) => a.time.compareTo(b.time));

    return messages;
    
  }

  void _sendMessage(ChatController chatController) {
    final text = chatController.textController.text.trim();
    if (text.isNotEmpty) {
      final message = Message(
        text: text,
        time: DateTime.now(),
        isSent: true,
      );


      // Add the user's message
      chatController.addMessage(widget.chat.username!, message);
      chatController.clearText();
    widget.controller.updateConversation(widget.chatIndex, ChatMessage(messages:[message]));

      // Handle auto-reply logic
      chatController.handleIncomingMessage(text, widget.chat.username!);

      // Reload messages and update UI
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final chat = widget.controller.chats[widget.chatIndex];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.chat.image!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                if (widget.chat.status!)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: CircleAvatar(
                      radius: 7,
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
                    ),
                  ),
                  widget.chat.status!
                      ? Text(
                          "Active Now",
                          style: TextStyle(
                            fontSize: 11,
                            fontFamily: "SfProDisplay",
                            color: Colors.grey,
                          ),
                        )
                      : DateTime.now()
                                  .difference(widget.chat.lastSeenTime!)
                                  .inMinutes <
                              60
                          ? Text(
                              "Active ${DateTime.now().difference(widget.chat.lastSeenTime!).inMinutes.toString()}m ago",
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: "SfProDisplay",
                                color: Colors.grey,
                              ))
                          : Text(
                              "Active ${DateTime.now().difference(widget.chat.lastSeenTime!).inHours.toString()}h ago",
                              style: TextStyle(
                                fontSize: 11,
                                fontFamily: "SfProDisplay",
                                color: Colors.grey,
                              ))
                ],
              ),
            ),
          ],
        ),
        flexibleSpace: Center(
          child: Row(
            children: [
              const Spacer(),
              IconButton(onPressed: () {}, icon: const Icon(Icons.call)),
              IconButton(onPressed: () {}, icon: const Icon(Icons.videocam)),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Chatprofilescreen(
                                chat: widget.chat,
                              )),
                    );
                  },
                  icon: const Icon(Icons.info_rounded)),
            ],
          ),
        ),
      ),
      body: Consumer<ChatController>(
        builder: (context, chatController, child) {
          final messages = _loadMessages(chatController); // Load messages
          if (messages.length > _prevMessageCount) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _scrollToBottom();
            });
            _prevMessageCount = messages.length;
          }
          return ListView(
            controller: _scrollController,
            children: [
              // Chat header content...
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: Image.asset(
                    widget.chat.image!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                widget.chat.username.toString(),
                style: const TextStyle(
                  fontFamily: "SfProDisplay",
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5),
              const Text(
                "You're friends on Facebook",
                style: TextStyle(
                  fontFamily: "SfProDisplay",
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "Lives in Tunis, Tunisia",
                style: TextStyle(
                  color: Colors.grey,
                  fontFamily: "SfProDisplay",
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Center(
                child: Container(
                  height: 25,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.grey[900],
                  ),
                  child: Center(
                    child: Text(
                      "View Profile",
                      style: TextStyle(
                        fontFamily: "SfProDisplay",
                        fontSize: 12,
                        color: Colors.grey[300],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 180),
              ...messages
                  .map((message) =>
                      MessageBubble(chat: widget.chat, message: message))
                  .toList(),
            ],
          );
        },
      ),
      bottomNavigationBar: Consumer<ChatController>(
        builder: (context, chatController, child) {
          return Row(
            children: [
              if (chatController.typing)
                IconButton(
                  onPressed: () {
                    chatController.setTyping(false);
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    size: 20,
                  ),
                ),
              if (!chatController.typing)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_circle_rounded),
                ),
              if (!chatController.typing)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.camera_alt),
                ),
              if (!chatController.typing)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.photo_outlined),
                ),
              if (!chatController.typing)
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.mic),
                ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: GestureDetector(
                    onDoubleTap: () {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AutoReplyDialog(chatController: chatController),
                      );
                    },
                    child: TextField(
                      controller: chatController.textController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        suffixIcon: IconButton(
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) {
                                return DraggableScrollableSheet(
                                  initialChildSize: 0.5,
                                  minChildSize: 0.25,
                                  maxChildSize: 0.9,
                                  builder: (context, scrollController) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      child: ListView(
                                        controller: scrollController,
                                        children: [
                                          Center(
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(16.0),
                                              child: Text("Drag me up!"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                          icon: const Icon(Icons.emoji_emotions),
                        ),
                        hintText: 'Message',
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontFamily: "SfProDisplay",
                        ),
                        filled: true,
                      ),
                      onChanged: (text) {
                        if (text.isEmpty) {
                          chatController.setTyping(false);
                        } else {
                          chatController.setTyping(true);
                        }
                      },
                      onTap: () {
                        chatController.setTyping(true);
                      },
                      onSubmitted: (text) {
                        _sendMessage(chatController);
                        chatController.setTyping(false);
                      },
                    ),
                  ),
                ),
              ),
              !chatController.typing
                  ? IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.thumb_up_off_alt_rounded),
                    )
                  : IconButton(
                      onPressed: () {
                        _sendMessage(chatController);
                        chatController.setTyping(false);
                      },
                      icon: const Icon(Icons.send),
                    )
            ],
          );
        },
      ),
    );
  }
}
