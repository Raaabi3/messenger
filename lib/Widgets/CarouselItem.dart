import 'package:flutter/material.dart';

class CarouselItem extends StatelessWidget {
  final String imagePath;
  final String label;

  const CarouselItem({
    Key? key,
    required this.imagePath,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 20,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.asset(
              imagePath,
              fit: BoxFit.fill,
            ),
          ),
        ),
        SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}