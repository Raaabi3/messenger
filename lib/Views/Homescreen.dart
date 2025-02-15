import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<Widget> items = [];
  bool isLoading = false;
  ScrollController _scrollController = ScrollController();

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
      List<Widget> newItems = List.generate(
          10, (index) => Text('User Name ${items.length + index + 1}'));
      setState(() {
        items.addAll(newItems);
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        flexibleSpace: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 20,
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
                padEnds: false),
            items: [
              // List of widgets to include in the carousel
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
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 1"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 2"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 3"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 4"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 5"),
                ],
              ),
              Column(
                children: [
                  CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          "assets/images/ProfilePic.jpeg",
                          fit: BoxFit.fill,
                        )),
                  ),
                  SizedBox(height: 8),
                  Text("User 6"),
                ],
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: items.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == items.length) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return ListTile(
                  leading: CircleAvatar(),
                  title: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
