import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  List<String> items = [];
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
      List<String> newItems =
          List.generate(10, (index) => 'User Name ${items.length + index + 1}');
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
        flexibleSpace: Column(
          children: [
            Row(
              children: [
                CircleAvatar(),
                Text("Charts"),
                Spacer(),
                Icon(Icons.camera_alt),
                Icon(Icons.edit_rounded),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          TextField(),
          CarouselSlider(
            options: CarouselOptions(
                height: 100.0,
                enableInfiniteScroll: false,
                viewportFraction: 0.2,
                padEnds: false),
            items: ["+", 1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 20,
                        child: Text(i.toString()),
                      ),
                      Text("name")
                    ],
                  );
                },
              );
            }).toList(),
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
                  title: Text(items[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
