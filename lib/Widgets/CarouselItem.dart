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
              radius: 20,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
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
                  backgroundColor: Colors.white,
                  child: CircleAvatar(
                    backgroundColor: Colors.green[400],
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
