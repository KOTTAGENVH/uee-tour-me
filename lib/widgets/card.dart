import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class CustomCardWithImage extends StatelessWidget {
  final String heading;
  final String subtitle;
  final String imagePath;
  final double imageWidth;
  final double cardHeight;
  final double imageHeight;
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
    this.imageWidth = 80.0,
    this.imageHeight = 80.0,
    this.cardHeight = 170,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 30),
      height: cardHeight,
      width: 5,
      decoration: BoxDecoration(
          border: Border.all(color: MyColors.pink, width: 1.5),
          borderRadius: BorderRadius.circular(20),
          color: Color.fromARGB(255, 0, 0, 0)),
      child: SizedBox(
        height: 180,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 180,
                child: Row(
                  children: [
                    SizedBox(
                      width: 140,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          alignment: Alignment.center,
                          imagePath,
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(
                        width: 20), // Add spacing between the image and titles
                    SizedBox(
                      width: 230,
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.only(
                                  top: 10, left: 40), // Adjust the top margin as needed
                              child: Text(
                                heading,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 20,  left: 60), // Adjust the top margin as needed
                              child: Text(
                                subtitle,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: 40,left: 60), // Adjust the top margin as needed
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  IconButton(
                                    onPressed: onPress1,
                                    icon: const Icon(Icons.visibility,
                                        color: MyColors.pink),
                                  ),
                                  IconButton(
                                    onPressed: onPress2,
                                    icon: const Icon(Icons.edit,
                                        color: MyColors.pink),
                                  ),
                                  IconButton(
                                    onPressed: onPress3,
                                    icon: const Icon(Icons.delete,
                                        color: MyColors.pink),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
