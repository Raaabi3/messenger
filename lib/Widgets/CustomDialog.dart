import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import '../Models/Chat.dart';
import '../Models/ChatMessage.dart';
import '../Controller/HomeController.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  _CustomDialogState createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController lastMessageController = TextEditingController();
  final TextEditingController sentMessageController = TextEditingController();
  final TextEditingController receivedMessageController =
      TextEditingController();
  bool isOnline = false;
  bool isDelivered = true;
  bool isRead = true;
  DateTime selectedTime = DateTime.now();
  File? _selectedImage; // To store the selected image

  @override
  void dispose() {
    usernameController.dispose();
    lastMessageController.dispose();
    sentMessageController.dispose();
    receivedMessageController.dispose();
    super.dispose();
  }

  // Method to pick an image from the gallery
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Add a Conversation",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 15),
            _buildAvatarPicker(),
            SizedBox(height: 15),
            _buildTextField(usernameController, "User Name"),
            SizedBox(height: 10),
            _buildTextField(lastMessageController, "Last Message"),
            SizedBox(height: 10),
            _buildTextField(sentMessageController, "Sent Message"),
            SizedBox(height: 10),
            _buildTextField(receivedMessageController, "Received Message"),
            SizedBox(height: 10),
            _buildCheckbox(
                "Online?", isOnline, (val) => setState(() => isOnline = val)),
            _buildCheckbox("Delivered?", isDelivered,
                (val) => setState(() => isDelivered = val)),
            _buildCheckbox(
                "Read?", isRead, (val) => setState(() => isRead = val)),
            SizedBox(height: 20),
            _buildActionButtons(context),
          ],
        ),
      ),
    );
  }

  Widget _buildAvatarPicker() {
    return GestureDetector(
      onTap: _pickImage, // Open image picker when tapped
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.grey[300],
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!), // Display selected image
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: _selectedImage == null
                ? Icon(Icons.add, color: Colors.grey[800])
                : null,
          ),
          SizedBox(width: 10),
          Text("User Avatar", style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(),
        filled: true,
      ),
    );
  }

  Widget _buildCheckbox(String label, bool value, Function(bool) onChanged) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 16)),
        Spacer(),
        Checkbox(value: value, onChanged: (val) => onChanged(val ?? false)),
      ],
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
            onPressed: () => Navigator.of(context).pop(),
            child: Text("Cancel", style: TextStyle(color: Colors.white))),
        SizedBox(width: 10),
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.grey[800]),
          onPressed: () {
            final homeController =
                Provider.of<HomescreenController>(context, listen: false);
            homeController.addChat(
              Chat(
                image: _selectedImage != null
                    ? _selectedImage!.path // Use selected image path
                    : "assets/images/noAvatar.jpg", // Default image
                username: usernameController.text.isEmpty
                    ? 'Zbiba'
                    : usernameController.text,
                lastmessage: lastMessageController.text.isEmpty
                    ? 'Running 15 mins late, traffic is crazy! 🚗'
                    : lastMessageController.text,
                lastSeenTime: DateTime.now().subtract(Duration(minutes: 15)),
                status: isOnline,
                received: isDelivered,
                read: isRead,
                time: selectedTime,
                conversations: [
                  ChatMessage(
                    sentMessage: sentMessageController.text.isEmpty
                        ? "Hey Sarah, are you on your way?"
                        : sentMessageController.text,
                    sentMessageTime:
                        DateTime.now().subtract(Duration(minutes: 30)),
                    receivedMessage: receivedMessageController.text.isEmpty
                        ? "Yes, but I'm stuck in traffic. Running 15 mins late!"
                        : receivedMessageController.text,
                    receivedMessageTime:
                        DateTime.now().subtract(Duration(minutes: 20)),
                  ),
                ],
              ),
            );
            Navigator.of(context).pop();
          },
          child: Text(
            "Add",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }
}