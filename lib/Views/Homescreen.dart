import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Models/Chat.dart';
import '../Widgets/CarouselItem.dart';
import '../Widgets/ChatListItem.dart';

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
      ..time = DateTime(2025, 2, 15, 14, 30),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'Michael Chen'
      ..lastmessage = 'Just sent the design mockups 📎'
      ..status = false
      ..received = false
      ..time = DateTime(2025, 2, 15, 12, 15),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'Emma Wilson'
      ..lastmessage = 'Coffee tomorrow? 9am at Blue Bottle? ☕'
      ..status = true
      ..received = true
      ..time = DateTime(2025, 2, 14, 18, 45),
    Chat()
      ..image = "assets/images/ProfilePic.jpeg"
      ..username = 'David Miller'
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
              icon: Stack(
                children: [
                  Icon(Icons.circle,
                      color: _selectedIndex == 2 ? Colors.black : Colors.grey),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Icon(
                      Icons.turn_slight_right_outlined,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset("assets/images/ProfilePic.jpeg")),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Chats",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SfProDisplay"),
                  ),
                  Spacer(),
                  CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(Icons.camera_alt)),
                  CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(Icons.edit_rounded)),
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Container(
              height: 34,
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(10)),
                  hintText: 'Search',
                  hintStyle:
                      TextStyle(color: Colors.grey, fontFamily: "SfProDisplay"),
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
                    child: Icon(Icons.add),
                  ),
                  SizedBox(height: 8),
                  Text("Story"),
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
                return ChatListItem(chat: chat[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}