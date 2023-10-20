import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';

class CategoryPage extends StatelessWidget {
  static const String routeName = '/category';
  const CategoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Select Category'),
      ),
      body: Column(children: [
        // Traveller
        Padding(
          padding: const EdgeInsets.all(8.0),
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
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: MyColors.pink,
                width: 2.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: MyColors.pink,
                width: 2.5,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
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
              borderRadius: BorderRadius.circular(10),
              side: const BorderSide(
                color: MyColors.pink,
                width: 2.5,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
