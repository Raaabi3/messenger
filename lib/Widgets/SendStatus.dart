import 'package:flutter/material.dart';

import '../Models/Chat.dart';

class Sendstatus extends StatelessWidget {
  final Chat chat;
  const Sendstatus({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return chat.received!
        ? chat.read!
            ? Icon(Icons.verified,color: Colors.blueAccent ,size: 20,)
            : Icon(Icons.verified_outlined,color: Colors.grey,size: 20)
        : Icon(Icons.circle_outlined ,color: Colors.grey,size: 20);
  }
}
