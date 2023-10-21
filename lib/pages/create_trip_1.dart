import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:tour_me/constants.dart';

class CreateTrip1 extends StatefulWidget {
  static const String routeName = '/createTrip1';
  const CreateTrip1({super.key});

  @override
  State<CreateTrip1> createState() => _CreateTrip1State();
}

class _CreateTrip1State extends State<CreateTrip1> {
  final TextEditingController _tripName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Create Trip'),
        ),
        body: Stack(
          children: [
            Expanded(
              child: FlutterMap(
                options: MyMap.intialLanka,
                children: [MyMap.tileLayer],
              ),
            ),
            Positioned(
              top: 15,
              left: 15,
              right: 15,
              child: TextField(
                decoration: const InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                ),
                controller: _tripName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
