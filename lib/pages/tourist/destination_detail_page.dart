import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/top_nav.dart';

class DestinationDetailPage extends StatefulWidget {
  static const String routeName = '/detailDestination';
  final String destinationId;
  final bool showBottonBar;

  const DestinationDetailPage({
    Key? key,
    required this.destinationId,
    this.showBottonBar = false,
  }) : super(key: key);

  @override
  State<DestinationDetailPage> createState() => _DestinationDetailPageState();
}

class _DestinationDetailPageState extends State<DestinationDetailPage> {
  String name = "";
  String desc = "";
  String imageUrl = "";
  String peak = '';

  @override
  void initState() {
    super.initState();
    _getLocationData();
    _getPeakH();
  }

  void _getPeakH() {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference docRef = firestore.collection('CalculatedPeakHours').doc(widget.destinationId);

    docRef.get().then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        // Access the specific property you want (e.g., 'propertyName')
        String startTime = data['startTime'];
        String endTime = data['endTime'];

        setState(() {
          peak = "$startTime - $endTime";
        });
      } else {
        print('Document does not exist');
      }
    }).catchError((error) {
      // Handle any errors that occur during the process
      print('Error getting document: $error');
    });
  }

  void _getLocationData() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentReference document = firestore.collection('Destination').doc(widget.destinationId);

    try {
      DocumentSnapshot documentSnapshot = await document.get();
      if (documentSnapshot.exists) {
        Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

        // Access specific properties from the document
        setState(() {
          name = data['destinationName'];
          desc = data['description'];
          imageUrl = data['destinationImage1'];
        });
      } else {
        throw 'Destination details not found';
      }
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNav(),
      body: Center(
        child: Container(
          decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
          child: Column(
            children: [
              imageUrl.trim().isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 300,
                      height: 300,
                    )
                  : const SizedBox(
                      height: 300,
                      width: 300,
                    ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 16, left: 30, right: 30),
                  decoration: const BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          desc,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        peak.trim().isNotEmpty ? peak : 'Not Busy',
                        style: const TextStyle(
                          fontSize: 10,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: widget.showBottonBar ? const BottomNav() : null,
    );
  }
}
