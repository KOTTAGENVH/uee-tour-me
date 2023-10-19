import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/top_nav.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  static const String routeName = '/testPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TopNav(),
          const SizedBox(height: 20),
          const Text(
            "Form",
            style: TextStyle(
              color: Color.fromARGB(255, 249, 250, 251),
              fontSize: 25,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Shop name',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.shop_2,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                 const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PinkButton(
                    onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                    text: 'Add Image',
                    icon:Icon( Icons.add_a_photo,color: Colors.white)
                  ),
                    const SizedBox(width: 10),
                    PinkButton(
                    onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                    text: 'Add Location',
                    icon: const Icon(Icons.location_on, color: Colors.white)
                  ),
                  ], // Add some spacing
                ),
                const SizedBox(height: 20), // Add some spacing
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Address',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.location_on,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20), // Add some spacing
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: const TextStyle(color: Colors.white),
                    prefixIcon: const Icon(
                      Icons.description,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: const Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  style: const TextStyle(color: Colors.white),
                   maxLines: 4,
                ),
                const SizedBox(height: 30),
                PinkButton(
                    onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                    text: 'Add Image',
                    icon:const Icon( Icons.add, color: Colors.white)
                  ),
              ],
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNav(),
    );
  }
}
