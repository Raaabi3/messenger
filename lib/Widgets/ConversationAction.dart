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
          ListTile(
            leading: Icon(Icons.delete_outline_rounded, size: 30),
            title: Text("Archive"),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.do_disturb_off_sharp, size: 30),
            title: Text("Ignore"),
            onTap: () {
              // Handle ignore action
            },
          ),
          ListTile(
            leading: Icon(Icons.person_add, size: 30),
            title: Text("Add members"),
            onTap: () {
              // Handle add members action
            },
          ),
          ListTile(
            leading: Icon(
              widget.chat.mute!
                  ? Icons.notifications_off_rounded
                  : Icons.notifications,
              size: 30,
            ),
            title: Text(widget.chat.mute! ? "Unmute" : "Mute"),
            onTap: () {
              setState(() {
                widget.chat.mute = !widget.chat.mute!;
              });
            },
          ),
          ListTile(
            leading: Icon(Icons.bubble_chart_rounded, size: 30),
            title: Text("Open chat head"),
            onTap: () {
              // Handle open chat head action
            },
          ),
          ListTile(
            leading: Icon(Icons.drafts_outlined, size: 30),
            title: Text("Mark as read"),
            onTap: () {
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app_rounded, size: 30, color: Colors.red),
            title: Text("Leave group", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle leave group action
            },
          ),
          ListTile(
            leading: Icon(Icons.delete, size: 30, color: Colors.red),
            title: Text("Delete", style: TextStyle(color: Colors.red)),
            onTap: () {
              // Handle delete action
            },
          ),
        ],
      ),
    );
  }
}