import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:messenger/Views/ChatScreen.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../Models/Chat.dart';
import '../Widgets/CarouselItem.dart';
import '../Widgets/ChatListItem.dart';
import '../Widgets/MessageAction.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Chat> chat = [];
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0; // Track the selected button index

  List<Chat> realisticChatData = [
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'Sarah Johnson'
      ..lastmessage = 'Running 15 mins late, traffic is crazy! 🚗'
      ..status = true
      ..received = true
      ..read = true
      ..time = DateTime(2025, 2, 15, 14, 30),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'Michael Chen'
      ..lastmessage = 'Just sent the design mockups 📎'
      ..status = false
      ..received = false
      ..read = false
      ..time = DateTime(2025, 2, 15, 12, 15),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'Emma Wilson'
      ..lastmessage = 'Coffee tomorrow? 9am at Blue Bottle? ☕'
      ..status = true
      ..read = false
      ..received = true
      ..time = DateTime(2025, 2, 14, 18, 45),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'David Miller'
      ..read = true
      ..lastmessage = 'Your package was delivered 📦'
      ..status = false
      ..received = true
      ..time = DateTime(2025, 2, 14, 10, 0),
  ];

  @override
  void initState() {
    super.initState();
    _loadMoreItems();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange) {
      _loadMoreItems();
    }
  }

  void _loadMoreItems() {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        chat.addAll(realisticChatData);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.chat_bubble_rounded),
              color: _selectedIndex == 0 ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 0; // Update selected index
                });
              },
            ),
            SizedBox(width: 50), // Add spacing between buttons
            IconButton(
              icon: Icon(Icons.supervisor_account_rounded),
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1; // Update selected index
                });
              },
            ),
            SizedBox(width: 50), // Add spacing between buttons
            IconButton(
              icon: Icon(Icons.explore),
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2; // Update selected index
                });
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        flexibleSpace: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/ProfilePic.jpeg"),
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SfProDisplay",
                      ),
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(Icons.camera_alt),
                  ),
                  SizedBox(width: 8), // Add spacing between icons
                  CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    child: Icon(Icons.edit_rounded),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
            child: Container(
              height: 34,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey,
                    fontFamily: "SfProDisplay",
                  ),
                  prefixIcon: Icon(Icons.search_sharp, color: Colors.grey),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
          ),
          SizedBox(height: 14),
          CarouselSlider(
            options: CarouselOptions(
              height: 100.0,
              enableInfiniteScroll: false,
              viewportFraction: 0.2,
              padEnds: false,
            ),
            items: [
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[100],
                    radius: 20,
                    child: Icon(
                      Icons.add,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Story",
                    style: TextStyle(
                        fontFamily: "SfProDisplay", color: Colors.grey),
                  ),
                ],
              ),
              ...List.generate(
                6,
                (index) => CarouselItem(
                  imagePath: "assets/images/ProfilePic.jpeg",
                  label: "User ${index + 1}",
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chat.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == chat.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: GestureDetector(
                    onLongPress: () {
                      showBarModalBottomSheet(
                        context: context,
                        builder: (context) =>
                            Container(height: 450, child: MessageAction()),
                      );
                    },
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Chatscreen(chat: chat[index],)),
                      );
                    },
                    child: ChatListItem(chat: chat[index]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
