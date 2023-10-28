import 'package:flutter/material.dart';

class ImageCard extends StatefulWidget {
  const ImageCard({Key? key}) : super(key: key);

  @override
  State<ImageCard> createState() => _ImageCardState();
}

class _ImageCardState extends State<ImageCard> with TickerProviderStateMixin {
  final List<String> imageUrls = [
    'assets/images/img1.jpg',
    'assets/images/img2.jpg',
    'assets/images/img3.jpg',
  ];

  int currentIndex = 0;

  // Track the favorite state for each image
  List<bool> isFavorite = List.filled(3, false);

  @override
  Widget build(BuildContext context) {
    final double imageBoxWidth = 300; // Adjust the width as needed
    final double imageBoxHeight = 200; // Adjust the height as needed

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 250,
            width: MediaQuery.of(context).size.width,
            child: PageView.builder(
              itemCount: imageUrls.length,
              padEnds: false,
              pageSnapping: false,
              physics: const BouncingScrollPhysics(),
              reverse: true,
              controller: PageController(
                initialPage: 3,
                viewportFraction: 0.7,
              ),
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    SizedBox(
                      width: imageBoxWidth,
                      height: imageBoxHeight,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            imageUrls[index],
                            fit: BoxFit.cover, // Adjust the BoxFit as needed
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Text(
                            'Image ${index + 1} Description',
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            isFavorite[index]
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: isFavorite[index] ? Colors.pink : Colors.white,
                          ),
                          onPressed: () {
                            setState(() {
                              isFavorite[index] = !isFavorite[index];
                            });
                          },
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
