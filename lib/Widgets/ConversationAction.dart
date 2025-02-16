import 'package:flutter/material.dart';

class ConversationAction extends StatelessWidget {
  const ConversationAction({super.key});

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
                onPressed: () {},
                icon: Icon(Icons.notifications),
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
