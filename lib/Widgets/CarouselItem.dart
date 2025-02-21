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
        Stack(
          children: [
            CircleAvatar(
              radius: 35,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  radius: 7,
                  child: CircleAvatar(
                    backgroundColor: const Color.fromARGB(255, 26, 187, 34),
                    radius: 5,
                  ),
                ))
          ],
        ),
        SizedBox(height: 8),
        Text(
          label,
          style: TextStyle(fontFamily: "SfProDisplay", color: Colors.grey,),
        ),
      ],
    );
  }
}
