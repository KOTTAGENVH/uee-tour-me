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
      height: cardHeight,      
      decoration: BoxDecoration(
        border: Border.all(color: MyColors.pink, width: 2.5),
        borderRadius: BorderRadius.circular(20),
        color: Color.fromARGB(255, 0, 0, 0)
      ),
      child: SizedBox(
        height: 200,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            children: [
              SizedBox(
                height: 150,          
                child: Row(
                  children: [
                    SizedBox(
                      width: 100,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          alignment: Alignment.center,
                          imagePath,
                          width: imageWidth,
                          height: imageHeight,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20), // Add spacing between the image and titles
                     SizedBox(
                      width: 230,
      
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: Column(
                          
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children:<Widget> [
                            Text(
                              heading,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 25,
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
