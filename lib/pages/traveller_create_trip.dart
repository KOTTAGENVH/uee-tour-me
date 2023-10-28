import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TravelerCreateTrip extends StatefulWidget {
  static const String routeName = '/travelrCreatetrip';
  const TravelerCreateTrip({super.key});

  @override
  State<TravelerCreateTrip> createState() => _TravelerCreateTripState();
}

class _TravelerCreateTripState extends State<TravelerCreateTrip> {
  Future<void> _postInit() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('Destination');

    try {
      QuerySnapshot querySnapshot = await collection.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Access specific properties from the document
        String location = data['location'];
        String image = data['destinationImage1'];
        String name = data['destinationName'];

        // Use the retrieved data as needed
        print('Location: $location');
        print('Image: $image');
        print('Name: $name');
        print('\n\n');
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  void initState() {
    _postInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNav(),
      bottomNavigationBar: const BottomNav(selcted: Selections.add),
      body: Container(
        decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
        child: SizedBox(),
      ),
    );
  }
}
