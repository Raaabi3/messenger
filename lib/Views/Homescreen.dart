import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../Controller/HomeController.dart';
import '../Models/Chat.dart';
import '../Models/Conversation.dart';
import '../Widgets/CarouselItem.dart';
import '../Widgets/ChatListItem.dart';
import '../Widgets/ConversationAction.dart';
import '../Widgets/CustomDialog.dart';
import '../Views/ChatScreen.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;

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
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent &&
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
      final homeController = Provider.of<HomescreenController>(context, listen: false);
      homeController.addChats([
        Chat(
          image: "assets/images/ProfilePic.jpeg",
          username: 'Sarah Johnson',
          lastmessage: 'Running 15 mins late, traffic is crazy! 🚗',
          lastSeenTime: DateTime.now().subtract(Duration(minutes: 15)),
          status: true,
          received: true,
          read: true,
          time: DateTime(2025, 2, 15, 14, 30),
          conversations: [
            Conversation(
              sentMessage: "Hey Sarah, are you on your way?",
              sentMessageTime: DateTime(2025, 2, 15, 14, 0),
              receivedMessage: "Yes, but I'm stuck in traffic. Running 15 mins late!",
              receivedMessageTime: DateTime(2025, 2, 15, 14, 10),
            ),
            Conversation(
              sentMessage: "No worries, take your time!",
              sentMessageTime: DateTime(2025, 2, 15, 14, 15),
            ),
          ],
        ),
        // Add more chats as needed
      ]);
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final homeController = Provider.of<HomescreenController>(context);

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
                  _selectedIndex = 0;
                });
              },
            ),
            SizedBox(width: 50),
            IconButton(
              icon: Icon(Icons.supervisor_account_rounded),
              color: _selectedIndex == 1 ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 1;
                });
              },
            ),
            SizedBox(width: 50),
            IconButton(
              icon: Icon(Icons.explore),
              color: _selectedIndex == 2 ? Colors.black : Colors.grey,
              onPressed: () {
                setState(() {
                  _selectedIndex = 2;
                });
              },
            ),
          ],
        ),
      ),
      floatingActionButton: homeController.addconv
          ? FloatingActionButton(
              mini: true,
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => CustomDialog(),
                );
              },
              child: Icon(Icons.add),
            )
          : null,
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
                  IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Chats",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: "SfProDisplay",
                      ),
                    ),
                  ),
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
      body: GestureDetector(
        onDoubleTap: homeController.setconv,
        child: Column(
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
                      radius: 30,
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
              child: Consumer<HomescreenController>(
                builder: (context, homeController, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount: homeController.chats.length + (isLoading ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index == homeController.chats.length) {
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
                              builder: (context) => Container(
                                  height: 450,
                                  child: ConversationAction(
                                    chat: homeController.chats[index],
                                  )),
                            );
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Chatscreen(
                                        chat: homeController.chats[index],
                                      )),
                            );
                          },
                          child: ChatListItem(chat: homeController.chats[index]),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}