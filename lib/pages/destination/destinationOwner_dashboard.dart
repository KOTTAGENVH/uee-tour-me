import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';

class DestinationHome extends StatefulWidget {
  const DestinationHome({super.key});

  @override
  State<DestinationHome> createState() => _DestinationHomeState();
}

class _DestinationHomeState extends State<DestinationHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: 20),
                width: 360, // Adjust width as needed
                height: 320, // Adjust height as needed
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.circular(20), // Adjust the border radius
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                      20), // Same border radius as the container
                  child: Image.asset(
                    'assets/images/destinationhome.jpg', // Replace with your image path
                    fit: BoxFit
                        .cover, // You can use a different BoxFit to control image scaling
                  ),
                ),
              ),
              // Add your text below the image
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold, // Make the text bold
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Container(
                width: 360, // Adjust width as needed
                height: 320, // Set marginTop as needed
                margin: EdgeInsets.only(top: 20), // Set marginTop as needed
                child: Text(
                  'Your Posted destinations would be displayed here',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center, // Align the text to the center
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
