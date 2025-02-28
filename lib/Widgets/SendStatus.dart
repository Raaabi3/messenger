import 'package:flutter/material.dart';

import '../Models/Chat.dart';

class Sendstatus extends StatefulWidget {
  final Chat chat;
  const Sendstatus({super.key, required this.chat});

  @override
  State<Sendstatus> createState() => _SendstatusState();
}

class _SendstatusState extends State<Sendstatus> {
  @override
  Widget build(BuildContext context) {
    return !widget.chat.mute!
        ? widget.chat.received!
                ? CircleAvatar(
                    radius: 10,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(widget.chat.image!),
                    ),
                  )
            : Icon(Icons.circle_outlined, color: Colors.grey, size: 20)
        : Icon(Icons.notifications_off_rounded, color: Colors.grey, size: 20);
  }
}
