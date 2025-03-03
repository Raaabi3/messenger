import 'package:flutter/material.dart';
import '../Controller/HomeController.dart';
import '../Widgets/SendStatus.dart';
import '../Models/Chat.dart';
import 'package:provider/provider.dart';

class ChatListItem extends StatelessWidget {
  final Chat chat;

  const ChatListItem({Key? key, required this.chat}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Access the controller from the provider
    final controller = Provider.of<HomescreenController>(context, listen: false);

    // Get the latest message text
    final latestMessageText = chat.conversations != null &&
            chat.conversations!.isNotEmpty &&
            chat.conversations!.last.messages.isNotEmpty
        ? chat.conversations!.last.messages.last.text
        : "No messages yet";

    // Get the formatted time
    final formattedTime = chat.time != null
        ? controller.formatTime(chat.time!)
        : "Unknown time";

    return ListTile(
      leading: Stack(
        children: [
          CircleAvatar(
            radius: 30,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.asset(
                chat.image!,
                fit: BoxFit.fill,
              ),
            ),
          ),
          !chat.status! &&
                  (DateTime.now().difference(chat.lastSeenTime!).inMinutes < 60)
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(width: 2),
                      color: const Color.fromARGB(255, 35, 65, 36)),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2.0),
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
        style: TextStyle(fontFamily: "SfProDisplay"),
      ),
      subtitle: Row(
        children: [
          Flexible(
            child: Text(
              "$latestMessageText • ",
              style: TextStyle(fontFamily: "SfProDisplay", color: Colors.grey),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Text(
            formattedTime,
            style: TextStyle(fontFamily: "SfProDisplay", color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
      trailing: Sendstatus(chat: chat),
    );
  }
}