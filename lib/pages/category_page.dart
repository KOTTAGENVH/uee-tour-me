import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Center(
             child: Image.asset(MyImages.logo
                  ,width: 100, 
                  height: 100),
           ),
                const SizedBox(height: 15),
                const Text('Pick Your Category',                  
                 style: TextStyle(color: Colors.white ,
                     fontSize: 30,
                     fontWeight: FontWeight.bold,), ),
                const SizedBox(height: 20),
          // Traveller
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              leading: Image.asset(MyImages.traveler),
              title: const Text(
                'Traveler',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              leading: Image.asset(MyImages.location),
              title: const Text(
                'Location Hosts',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ListTile(
              leading: Image.asset(MyImages.merchant),
              title: const Text(
                'Merchants',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: MyColors.pink,
                ),
              ),
              contentPadding: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(
                  color: MyColors.pink,
                  width: 2.5,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
