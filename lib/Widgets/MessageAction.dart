import 'package:flutter/material.dart';

class MessageAction extends StatelessWidget {
  const MessageAction({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.reply),
                iconSize: 30,
                color: Colors.purple[300],
              ),
              Text("Reply"),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.copy),
                iconSize: 30,
                color: Colors.purple[300],
              ),
              Text("Copy"),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.push_pin),
                iconSize: 30,
                color: Colors.purple[300],
              ),
              Text("Pin"),
            ],
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.menu),
                iconSize: 30,
                color: Colors.purple[300],
              ),
              Text("More"),
            ],
          ),
        ],
      ),
    );
  }
}
