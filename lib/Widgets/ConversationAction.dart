import 'package:flutter/material.dart';
import 'package:messenger/Models/Chat.dart';

class ConversationAction extends StatefulWidget {
  final Chat chat;
  const ConversationAction({super.key, required this.chat});

  @override
  State<ConversationAction> createState() => _ConversationActionState();
}

class _ConversationActionState extends State<ConversationAction> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete_outline_rounded),
                iconSize: 30,
              ),
              Text("Archive"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.do_disturb_off_sharp),
                iconSize: 30,
              ),
              Text("Ignore"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.person_add),
                iconSize: 30,
              ),
              Text("Add members"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    widget.chat.mute = !widget.chat.mute;
                  });
                },
                icon: widget.chat.mute
                    ? Icon(Icons.notifications_off_rounded)
                    : Icon(Icons.notifications),
                iconSize: 30,
              ),
              Text("Unmute"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.bubble_chart_rounded),
                iconSize: 30,
              ),
              Text("Open chat head"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.drafts_outlined),
                iconSize: 30,
              ),
              Text("Mark as read"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.exit_to_app_rounded),
                color: Colors.red,
                iconSize: 30,
              ),
              Text("Leave group"),
            ],
          ),
          Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.delete),
                color: Colors.red,
                iconSize: 30,
              ),
              Text("Delete"),
            ],
          )
        ],
      ),
    );
  }
}
