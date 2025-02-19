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
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                chat.image!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          chat.lastSeenTime != DateTime.now &&
                  (DateTime.now().difference(chat.lastSeenTime!).inMinutes < 60)
              ? Positioned(
                  bottom: -2,
                  right: -2,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: Colors.white,width:2),
                      color: const Color.fromARGB(255, 35, 65, 36)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal:  2.0),
                      child: Text(
                        "${DateTime.now().difference(chat.lastSeenTime!).inMinutes.toString()}m",
                        style: TextStyle(
                            fontFamily: "SfProDisplay",
                            fontSize: 7,
                            color: const Color.fromARGB(255, 25, 199, 31)),
                      ),
                    ),
                  ),
                )
              : Positioned(
                  bottom: -2,
                  right: -2,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 31, 177, 35),
                      radius: 6,
                    ),
                  ),
                )
        ],
      ),
      title: Text(
        chat.username!,
        style:
            TextStyle(fontFamily: "SfProDisplay", fontWeight: FontWeight.bold),
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              "You: ${chat.lastmessage} • ",
              style: TextStyle(fontFamily: "SfProDisplay", color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            controller.formatTime(chat.time!),
            style: TextStyle(fontFamily: "SfProDisplay", color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Sendstatus(chat: chat),
    );
  }
}
