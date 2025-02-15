import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../Controller/HomeController.dart';
import '../Models/Helpers/MessageItem .dart';

class MessageBubble extends StatefulWidget {
  final MessageItem message;

  const MessageBubble({super.key, required this.message});

  @override
  State<MessageBubble> createState() => _MessageBubbleState();
}

class _MessageBubbleState extends State<MessageBubble> {
  bool _showTime = false;
  Widget build(BuildContext context) {
    return Column(
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
              maxWidth: MediaQuery.of(context).size.width *
                  0.7, 
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize
                      .min,
                  crossAxisAlignment: CrossAxisAlignment
                      .end, 
                  children: [
                    if (!widget.message.isSent)
                      const Padding(
                        padding: EdgeInsets.only(
                            right: 8),
                        child: CircleAvatar(
                          backgroundImage: AssetImage(
                              "assets/images/ProfilePic.jpeg"), 
                          radius: 16,
                        ),
                      ),
                    Flexible(
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            _showTime =
                                !_showTime; 
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 4),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: widget.message.isSent
                                ? Colors.purple[100]
                                : Colors.grey[200],
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
                            softWrap:
                                true, 
                            overflow: TextOverflow
                                .visible, 
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
