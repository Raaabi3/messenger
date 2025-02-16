import 'package:flutter/material.dart';

class Chatprofilescreen extends StatelessWidget {
  const Chatprofilescreen({super.key});

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
                  const CircleAvatar(
                    radius: 40,
                    backgroundImage: AssetImage("assets/images/ProfilePic.jpeg"), // Add your image asset
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "User",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "efzefzef",
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(height: 20),
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    child: const Icon(Icons.facebook_outlined, color: Colors.blue),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "Profile",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Customization Section
            _buildSectionTitle("Customization"),
            _buildListTile(Icons.stop_circle_rounded, Colors.green, "Theme"),
            _buildListTile(Icons.thumb_up_off_alt_rounded, Colors.blue, "Quick reaction"),
            _buildListTile(Icons.text_fields, Colors.black, "Nicknames"),
            _buildListTile(Icons.edit, Colors.black, "Word effects"),
            const Divider(),

            // More Actions Section
            _buildSectionTitle("More Actions"),
            _buildListTile(Icons.photo_outlined, Colors.black, "View media, files & links"),
            _buildListTile(Icons.save_alt_rounded, Colors.black, "Save photos & videos"),
            _buildListTile(Icons.push_pin, Colors.black, "View pinned messages"),
            _buildListTile(Icons.search, Colors.black, "Search in conversation"),
            _buildListTile(Icons.people_alt_rounded, Colors.black, "Create group chat with *User*"),
            _buildListTile(Icons.share, Colors.black, "Share contact"),
            const Divider(),

            // Privacy & Support Section
            _buildSectionTitle("Privacy & Support"),
            _buildListTile(Icons.lock, Colors.black, "Verify end-to-end encryption"),
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
          fontSize: 18,
          fontWeight: FontWeight.bold,
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
          fontSize: 16,
        ),
      ),
      onTap: () {
        // Add functionality here
      },
    );
  }
}