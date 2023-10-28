// ignore_for_file: use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/suggestiontime/adddestintionpeakhours.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/labeled_divider.dart';
import 'package:tour_me/widgets/next_back_button.dart';

class ValidateDestinationToken extends StatefulWidget {
  static const String routeName = '/validateToken';
  const ValidateDestinationToken({super.key});

  @override
  State<ValidateDestinationToken> createState() => _ValidateDestinationToken();
}

class _ValidateDestinationToken extends State<ValidateDestinationToken> {
  final TextEditingController _tokenvalidating = TextEditingController();

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title:
              const Text('Suggest Peak Hours', style: TextStyle(fontSize: 25)),
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
          child: Column(
        children: [
          // const SizedBox(height: 40),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 25, right: 20),
            width: 360, // Adjust width as needed
            height: 220, // Adjust height as needed
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.circular(20), // Adjust the border radius
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                  20), // Same border radius as the container
              child: Image.asset(
                'assets/images/validatetokenimage.jpg', // Replace with your image path
                fit: BoxFit
                    .cover, // You can use a different BoxFit to control image scaling
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(
                bottom: 20, top: 80), // Adjust the margin as needed
            child: const LabeledDivider(label: 'Enter Destination Token'),
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 350, // Set your desired width here
            child: Container(
              child: TextFormField(
                controller: _tokenvalidating,
                decoration: InputDecoration(
                  labelText: 'Enter Token',
                  labelStyle: const TextStyle(color: Colors.white),
                  prefixIcon: const Icon(
                    Icons.key,
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
                maxLines: 1,
              ),
            ),
          ),

          Container(
              margin: const EdgeInsets.only(top: 40), // Add top margin here
              child: NextButton(
                  onPress: () async {
                    String enteredToken = _tokenvalidating.text;

                    // Check if the entered token exists in the Destination collection
                    QuerySnapshot querySnapshot = await _destination
                        .where('token', isEqualTo: enteredToken)
                        .get();

                    if (querySnapshot.docs.isNotEmpty) {
                      // Token is valid, show a success message or perform actions
                      final DocumentSnapshot firstDocument =
                          querySnapshot.docs.first;

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddDestinationPeak(
                            destinationid: firstDocument.id,
                            destinationName: firstDocument['destinationName'],
                            city: firstDocument['city'],
                            destinationImage1:
                                firstDocument['destinationImage1'],
                            destinationImage2:
                                firstDocument['destinationImage2'],
                            token: firstDocument['token'],
                            userId: firstDocument['userId'],
                          ),
                        ),
                      );

                      // showDialog(
                      //   context: context,
                      //   builder: (BuildContext context) {
                      //     return AlertDialog(
                      //       title: Text('Token Valid'),
                      //       content: Text('The entered token is valid.'),
                      //       actions: <Widget>[
                      //         TextButton(
                      //           child: Text('OK'),
                      //           onPressed: () {
                      //             Navigator.of(context).pop();
                      //           },
                      //         ),
                      //       ],
                      //     );
                      //   },
                      // );
                    } else {
                      // Token is invalid, show an error message or perform other actions
                      // For example, show a dialog to indicate an invalid token
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Token Invalid'),
                            content:
                                const Text('The entered token is invalid.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('OK'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  text: "Validate Token")),
        ],
      )),
      backgroundColor: Colors.black,
      // bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
