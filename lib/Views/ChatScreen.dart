import 'package:flutter/material.dart';
import 'package:messenger/Views/ChatProfileScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import '../Controller/ChatController.dart';
import '../Models/Chat.dart';
import '../Models/Helpers/Message.dart';
import '../Widgets/MessageBubble.dart';

class Chatscreen extends StatefulWidget {
  final Chat chat;

  const Chatscreen({super.key, required this.chat});

  @override
  State<Chatscreen> createState() => _ChatscreenState();
}

class _ChatscreenState extends State<Chatscreen> {
  List<Message> messages = [];
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  void _loadMessages() {
    messages = context.read<ChatController>().getMessages();
    if (widget.chat.conversations != null) {
      for (var conversation in widget.chat.conversations!) {
        if (conversation.sentMessageTime != null) {
          messages.add(Message(
            text: conversation.sentMessage!,
            time: conversation.sentMessageTime!,
            isSent: true,
          ));
        }
        if (conversation.receivedMessageTime != null) {
          messages.add(Message(
            text: conversation.receivedMessage!,
            time: conversation.receivedMessageTime!,
            isSent: false,
          ));
        }
      }
    }

    messages.sort((a, b) => a.time.compareTo(b.time));
  }

  void _sendMessage(ChatController chatController) {
  final text = chatController.textController.text.trim();
  if (text.isNotEmpty) {
    final message = Message(
      text: text,
      time: DateTime.now(),
      isSent: true,
    );

    setState(() {
      messages.add(message);
    });

    chatController.addMessage(message);
    chatController.clearText();

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
    final chatController = Provider.of<ChatController>(context);

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
      body: ListView(
        controller: _scrollController,
        children: [
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
                  color: Colors.grey[900]),
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
                  MessageBubble(chat: widget.chat!, message: message))
              .toList(),
        ],
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
                            isScrollControlled:
                                true, // Allows the sheet to expand and push content up
                            backgroundColor: Colors
                                .transparent, // Optional: For a transparent background
                            builder: (context) {
                              return DraggableScrollableSheet(
                                initialChildSize:
                                    0.5, // Initial size (50% of the screen)
                                minChildSize:
                                    0.25, // Minimum size when collapsed
                                maxChildSize:
                                    0.9, // Maximum size (90% of the screen)
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
                                            padding: const EdgeInsets.all(16.0),
                                            child: Text("Drag me up!"),
                                          ),
                                        ),
                                        // Add more widgets here
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
