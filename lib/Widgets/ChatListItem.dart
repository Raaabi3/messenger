import 'package:flutter/material.dart';
import '../Controller/HomeController.dart';
import '../Models/Chat.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final HomescreenController controller = HomescreenController(); // Create an instance of the controller

   ChatListItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.asset(
            chat.image!,
            fit: BoxFit.fill,
          ),
        ),
      ),
      title: Text(chat.username!),
      subtitle: Text(
        "You: ${chat.lastmessage} • ${controller.formatTime(chat.time!)}",
        //overflow: TextOverflow.ellipsis,
      ),
      trailing: chat.status!
          ? Icon(
              Icons.circle_outlined,
              color: Colors.grey[500],
              size: 20,
            )
          : Icon(
              Icons.verified_outlined,
              color: Colors.grey[500],
              size: 20,
            ),
    );
  }
}