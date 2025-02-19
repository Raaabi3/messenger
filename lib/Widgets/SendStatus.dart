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
    return !widget.chat.mute ? widget.chat.received! 
        ? widget.chat.read!
            ? Icon(Icons.check_circle,color: Colors.blueAccent ,size: 20,)
            : Icon(Icons.check_circle_outline,color: Colors.grey,size: 20)
        : Icon(Icons.circle_outlined ,color: Colors.grey,size: 20) :
        Icon(Icons.notifications_off_rounded ,color: Colors.grey,size: 20); 
  }
}
