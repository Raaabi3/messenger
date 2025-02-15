import 'package:flutter/material.dart';
import '../Controller/HomeController.dart';
import '../Widgets/SendStatus.dart';
import '../Models/Chat.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;
  final HomescreenController controller = HomescreenController(); 

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
      title: Text(chat.username!,style: TextStyle(fontFamily: "SfProDisplay" , fontWeight: FontWeight.bold),),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              "You: ${chat.lastmessage} • ",
              style: TextStyle(fontFamily: "SfProDisplay" ,color: Colors.grey),

              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            controller.formatTime(chat.time!),
                          style: TextStyle(fontFamily: "SfProDisplay" ,color: Colors.grey),

            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Sendstatus(chat: chat),
    );
  }
}