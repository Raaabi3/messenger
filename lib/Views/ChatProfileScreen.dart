import 'package:flutter/material.dart';

import '../Models/Chat.dart';

class Chatprofilescreen extends StatefulWidget {
  final Chat chat;

  const Chatprofilescreen({super.key, required this.chat});

  @override
  State<Chatprofilescreen> createState() => _ChatprofilescreenState();
}

class _ChatprofilescreenState extends State<Chatprofilescreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [Icon(Icons.more_vert_outlined)],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Profile Section
            Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage(
                            "assets/images/ProfilePic.jpeg"), // Add your image asset
                      ),
                      Positioned(
                          bottom: 0,
                          right: 0,
                          child: CircleAvatar(
                              radius: 10,
                              backgroundColor:
                                  const Color.fromARGB(255, 27, 59, 29),
                              child: (widget.chat.lastSeenTime !=
                                          DateTime.now &&
                                      (DateTime.now()
                                              .difference(
                                                  widget.chat.lastSeenTime!)
                                              .inMinutes <
                                          60)
                                  ? Text(
                                      "${DateTime.now().difference(widget.chat.lastSeenTime!).inMinutes.toString()}m",
                                      style: TextStyle(
                                          fontFamily: "SfProDisplay",
                                          fontSize: 9,
                                          color: Colors.green),
                                    )
                                  : CircleAvatar(
                                      backgroundColor:
                                          const Color.fromARGB(255, 1, 212, 8),
                                      radius: 7,
                                    )))),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.chat.username!,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Container(
                    width: 180,
                    decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(30)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.lock,
                            size: 15,
                          ),
                          Text(
                            "End-to-end encrypted",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.call, color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Audio",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.videocam_sharp,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Video",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.facebook_outlined,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Profile",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: const Icon(Icons.notifications,
                                color: Colors.grey),
                          ),
                          const SizedBox(height: 10),
                          const Text(
                            "Mute",
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Customization Section
            _buildSectionTitle("Customization"),
            _buildListTile(Icons.stop_circle_rounded, Colors.green, "Theme"),
            _buildListTile(
                Icons.thumb_up_off_alt_rounded, Colors.blue, "Quick reaction"),
            _buildListTile(Icons.text_fields, Colors.black, "Nicknames"),
            _buildListTile(Icons.edit, Colors.black, "Word effects"),

            // More Actions Section
            _buildSectionTitle("More Actions"),
            _buildListTile(Icons.photo_outlined, Colors.black,
                "View media, files & links"),
            _buildListTile(
                Icons.save_alt_rounded, Colors.black, "Save photos & videos"),
            _buildListTile(
                Icons.push_pin, Colors.black, "View pinned messages"),
            _buildListTile(
                Icons.search, Colors.black, "Search in conversation"),
            _buildListTile(Icons.people_alt_rounded, Colors.black,
                "Create group chat with *User*"),
            _buildListTile(Icons.share, Colors.black, "Share contact"),

            // Privacy & Support Section
            _buildSectionTitle("Privacy & Support"),
            _buildListTile(
                Icons.lock, Colors.black, "Verify end-to-end encryption"),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.report_problem_rounded, color: Colors.red),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Report",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "Give feedback and report conversation",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to build section titles
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.bold,
          color: Color.fromARGB(255, 66, 66, 66),
          fontFamily: "SfProDisplay",
        ),
      ),
    );
  }

  // Helper method to build list tiles
  Widget _buildListTile(IconData icon, Color iconColor, String title) {
    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(
        title,
        style: const TextStyle(
          fontSize: 14,
          fontFamily: "SfProDisplay",
        ),
      ),
      onTap: () {
        // Add functionality here
      },
    );
  }
}
