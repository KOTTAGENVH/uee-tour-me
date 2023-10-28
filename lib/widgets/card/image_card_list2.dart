import 'package:flutter/material.dart';
import 'package:tour_me/widgets/card/image_card_widget.dart';

class ImageCardList2 extends StatelessWidget {
  final List<Map<String, String>> images = [
    {'path': 'assets/images/img1.jpg', 'name': 'Image 1'},
    {'path': 'assets/images/img1.jpg', 'name': 'Image 2'},
    {'path': 'assets/images/img1.jpg', 'name': 'Image 3'},
    // Add more image data here
  ];

  ImageCardList2({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2, // Display two cards per row
      children: List.generate(images.length, (index) {
        return ImageCardWidget(
          imagePath: images[index]['path']!,
          name: images[index]['name']!,
        );
      }),
    );
  }
}