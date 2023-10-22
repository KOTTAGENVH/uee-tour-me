import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class CustomCardWithImage extends StatelessWidget {
  final String heading;
  final String subtitle;
  final String imagePath;
  final double imageWidth;
  final double cardHeight;
  final VoidCallback onPress1;
  final VoidCallback onPress2;
  final VoidCallback onPress3;

  const CustomCardWithImage({
    Key? key,
    required this.heading,
    required this.subtitle,
    required this.imagePath,
    required this.onPress1,
    required this.onPress2,
    required this.onPress3,
    this.imageWidth = 100.0,
    this.cardHeight = 180,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: cardHeight,
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.pink, width: 2.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Image.asset(
                imagePath,
                width: imageWidth,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 10), // Add spacing between the image and titles
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    heading,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            
            mainAxisAlignment: MainAxisAlignment.end, // Align buttons to the right
            children:
             [
              IconButton(
                onPressed: onPress1,
                icon: const Icon(Icons.visibility, color: MyColors.pink),
              ),
              IconButton(
                onPressed: onPress2,
                icon: const Icon(Icons.edit, color: MyColors.pink),
              ),
              IconButton(
                onPressed:onPress3,
                icon: const Icon(Icons.delete, color: MyColors.pink),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
