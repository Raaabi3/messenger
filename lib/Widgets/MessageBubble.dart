  import 'package:flutter/material.dart';
  import 'package:intl/intl.dart';
  import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
  import '../Models/Chat.dart';
  import '../Models/Helpers/Message.dart';
  import 'MessageAction.dart';

  class MessageBubble extends StatefulWidget {
    final Message message;
    final Chat chat;


    const MessageBubble({super.key,required this.chat, required this.message});

    @override
    State<MessageBubble> createState() => _MessageBubbleState();
  }

  class _MessageBubbleState extends State<MessageBubble> {
    bool _showTime = false;
    Widget build(BuildContext context) {
      return Stack(
        children: [
          Column(
            children: [
              if (_showTime)
                Padding(
                  padding: const EdgeInsets.only(top: 4),
                  child: Text(
                    _formatTime(widget.message.time),
                    style: const TextStyle(
                      fontSize: 10,
                      fontFamily: "SfProDisplay",
                      color: Colors.grey,
                    ),
                  ),
                ),
              Align(
                alignment: widget.message.isSent
                    ? Alignment.centerRight
                    : Alignment.centerLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (!widget.message.isSent)
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: CircleAvatar(
                                backgroundImage:
                                    AssetImage(widget.chat.image!),
                                radius: 16,
                              ),
                            ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  _showTime = !_showTime;
                                });
                              },
                              onLongPress: () {
                                showMaterialModalBottomSheet(
                                  barrierColor: Colors.transparent,
                                  context: context,
                                  builder: (context) => Container(
                                      height: 100, child: MessageAction()),
                                );
                                final RenderBox renderBox =
                                    context.findRenderObject() as RenderBox;
                                final Offset offset =
                                    renderBox.localToGlobal(Offset.zero);

                                showMenu(
                                  context: context,
                                  position: RelativeRect.fromLTRB(
                                    offset.dx + 50, 
                                    offset.dy, 
                                    offset.dx + renderBox.size.width, 
                                    offset.dy + renderBox.size.height,
                                  ),
                                  items: [
                                    PopupMenuItem(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.emoji_emotions)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.emoji_emotions)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.emoji_emotions)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.emoji_emotions)),
                                          IconButton(
                                              onPressed: () {},
                                              icon: Icon(Icons.emoji_emotions)),
                                          IconButton(
                                            onPressed: () {},
                                            icon: Icon(Icons.add_circle),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                );
                              },
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 4),
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: widget.message.isSent
                                      ? const Color.fromARGB(255, 43, 0, 51)
                                      : const Color.fromARGB(255, 24, 24, 24),
                                  borderRadius: BorderRadius.only(
                                    topLeft: const Radius.circular(50),
                                    topRight: const Radius.circular(50),
                                    bottomLeft: widget.message.isSent
                                        ? const Radius.circular(50)
                                        : Radius.zero,
                                    bottomRight: widget.message.isSent
                                        ? Radius.zero
                                        : const Radius.circular(50),
                                  ),
                                ),
                                child: Text(
                                  widget.message.text,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontFamily: "SfProDisplay",
                                  ),
                                  softWrap: true,
                                  overflow: TextOverflow.visible,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }
  }

  String _formatTime(DateTime time) {
    DateTime now = DateTime.now();
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      return DateFormat('h:mm a').format(time);
    } else {
      return DateFormat('EEE, h:mm a').format(time);
    }
  }
