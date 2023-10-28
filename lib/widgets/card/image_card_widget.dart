import 'package:flutter/material.dart';

class ImageCardWidget extends StatelessWidget {
  final String imagePath;
  final String name;

  ImageCardWidget({
    required this.imagePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    const double imageBoxWidth = 150;
    const double imageBoxHeight = 250;
   const double borderRadius = 15.0; // Adjust the value for the desired curve amount

    return SizedBox(
      width: imageBoxWidth,
      height: imageBoxHeight,
      child: Stack(
        children: [
          SizedBox(
            width: imageBoxWidth,
            height: imageBoxHeight,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(borderRadius), // Match the Card's borderRadius
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(borderRadius),
                topRight: Radius.circular(borderRadius),
              ),
              child: Container(
                color: Colors.black.withOpacity(0.7),
                 width: 7,
      height: 40,
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 255, 255, 255),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.pink,
                      ),
                      onPressed: () {
                        // Handle favorite button press here
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
