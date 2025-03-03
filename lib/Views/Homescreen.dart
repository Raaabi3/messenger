import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../Controller/HomeController.dart';
import '../Controller/ThemeProvider.dart';
import '../Models/Helpers/mock_data.dart';
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

  Map<int, String> imageslist = {
    1: "Aya zitouna",
    2: "Salima azzi",
    3: "Angel Garvin",
    4: "Islam Mansouri"
  };

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
      final homeController =
          Provider.of<HomescreenController>(context, listen: false);
      homeController.addChats(mockChats); // Use the mock data

      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final homeController = Provider.of<HomescreenController>(context);

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(
                    Icons.chat_bubble_rounded,
                  ),
                  color: _selectedIndex == 0 ? Colors.blue : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 0;
                    });
                  },
                ),
                Text(
                  "Chats",
                  style: TextStyle(
                      fontFamily: "SfProDisplay",
                      fontSize: 11,
                      color: _selectedIndex == 0 ? Colors.blue : Colors.grey),
                )
              ],
            ),
            SizedBox(width: 50),
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.web_stories),
                  color: _selectedIndex == 2 ? Colors.blue : Colors.grey,
                  onPressed: () {
                    setState(() {
                      _selectedIndex = 2;
                    });
                  },
                ),
                Text(
                  "Stories",
                  style: TextStyle(
                      fontFamily: "SfProDisplay",
                      fontSize: 11,
                      color: _selectedIndex == 2 ? Colors.blue : Colors.grey),
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: homeController.addconv
          ? Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  mini: true,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => CustomDialog(),
                    );
                  },
                  child: Icon(Icons.add),
                ),
                Switch(
                  value: themeProvider.themeMode == ThemeMode.dark,
                  onChanged: (value) => themeProvider.toggleTheme(),
                ),
              ],
            )
          : null,
      drawer: Drawer(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  radius: 20,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset("assets/images/me.jpg"),
                  ),
                ),
                title: Row(
                  children: [
                    Text(
                      "Mohamed Ben R..",
                      style:
                          TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                    ),
                    Icon(Icons.keyboard_arrow_down_sharp),
                    Spacer(),
                    Icon(Icons.settings)
                  ],
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                selected: true,
                selectedTileColor: Colors.grey[800],
                selectedColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chat_bubble,
                      ),
                    )),
                title: Text(
                  "Chats",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.store_mall_directory,
                      ),
                    )),
                title: Text(
                  "Marketplace",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.chat_rounded,
                      ),
                    )),
                title: Text(
                  "Message Requests",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.archive,
                      ),
                    )),
                title: Text(
                  "Archive",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "More",
                style: TextStyle(
                    fontFamily: "SfProDisplay",
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.people,
                      ),
                    )),
                title: Text(
                  "Friend Requests",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.voice_chat,
                      ),
                    )),
                title: Text(
                  "Channel invites",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 18.0),
              child: Text(
                "Communities",
                style: TextStyle(
                    fontFamily: "SfProDisplay",
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.add,
                      ),
                    )),
                title: Text(
                  "Create community",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                "Facebook groups",
                style: TextStyle(
                    fontFamily: "SfProDisplay",
                    fontSize: 15,
                    color: Colors.grey),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ListTile(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                leading: Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[800],
                        borderRadius: BorderRadius.circular(10)),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Icon(
                        Icons.check_box_outline_blank,
                      ),
                    )),
                title: Text(
                  "Anything",
                  style: TextStyle(fontFamily: "SfProDisplay", fontSize: 15),
                ),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        toolbarHeight: 60,
        leading: Builder(
          builder: (context) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  IconButton.filled(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 8,
                        child: CircleAvatar(
                          radius: 5,
                          backgroundColor: Colors.red,
                        ),
                      ))
                ],
              ),
            );
          },
        ),
        title: Row(
          children: [
            Text(
              "Chats",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: "SfProDisplay",
              ),
            ),
            Spacer(),
            IconButton.filled(onPressed: () {}, icon: Icon(Icons.mode_edit_rounded,size: 18,)),
          ],
        ),
      ),
      body: GestureDetector(
        onDoubleTap: homeController.setconv,
        child: Column(
          children: [
            Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10),
                child: Container(
                  height: 35,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Ask Meta AI or Search',
                      hintStyle: TextStyle(
                        color: Colors.grey[600],
                        fontFamily: "SfProDisplay",
                      ),
                      prefixIcon: Image.asset(
                        "assets/images/meta-ai.png",
                        scale: 12,
                      ),
                      filled: true,
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 0), // Adjust vertical padding
                    ),
                  ),
                )),
            SizedBox(height: 14),
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: CarouselSlider(
                    options: CarouselOptions(
                      height: 100.0,
                      enableInfiniteScroll: false,
                      viewportFraction: 0.25,
                      padEnds: false,
                    ),
                    items: [
                      Column(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(35),
                              child: Image.asset(
                                "assets/images/me.jpg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            "Your Note",
                            style: TextStyle(
                                fontFamily: "SfProDisplay",
                                color: Colors.grey[700]),
                          ),
                        ],
                      ),
                      ...List.generate(homeController.chats.length, (index) {
                        if (index < homeController.chats.length) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Chatscreen(
                                          chat: homeController.chats[index], controller: homeController, chatIndex: index,
                                        )),
                              );
                            },
                            child: CarouselItem(
                              imagePath: homeController.chats[index].image!,
                              label: homeController.chats[index].username!
                                  .split(" ")[0],
                            ),
                          );
                        } else {
                          // Return a placeholder or empty widget if the index is out of bounds
                          return SizedBox.shrink();
                        }
                      }),
                    ],
                  ),
                ),
                /*Positioned(
                            left: 7,
                            top: 0,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey[800],
                                borderRadius: BorderRadius.circular(20)
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Drop a thought",
                                  style: TextStyle(
                                    fontFamily: "SfProDisplay",
                                    fontSize: 10,
                                    color: Colors.grey
                                  ),
                                ),
                              ),
                              
                            ),
                          )*/
              ],
            ),
            Expanded(
              child: Consumer<HomescreenController>(
                builder: (context, homeController, child) {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        homeController.chats.length + (isLoading ? 1 : 0),
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
                              backgroundColor:
                                  const Color.fromARGB(255, 34, 33, 33),
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
                                        chat: homeController.chats[index], controller: homeController, chatIndex: index,
                                      )),
                            );
                          },
                          child:
                              ChatListItem(chat: homeController.chats[index]),
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
