import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/updateDestination.dart';
import 'package:tour_me/widgets/card.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/message_popup.dart';
import 'package:tour_me/widgets/pink_button.dart';

class DestinationHome extends StatefulWidget {
  static const String routeName = '/destinationHome';
  const DestinationHome({super.key});

  @override
  State<DestinationHome> createState() => _DestinationHomeState();
}

class _DestinationHomeState extends State<DestinationHome> {
  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');
  SecureSharedPref? pref;
  String? userId;

  List<DocumentSnapshot> destinationList = [];

  @override
  void initState() {
    super.initState();
    initPreferences();
  }

  Future<void> initPreferences() async {
    pref = await SecureSharedPref.getInstance();
    userId = await pref?.getString(MyPrefTags.userId, isEncrypted: true);
    QuerySnapshot querySnapshot;
    // Perform the query to get destinations where userId matches
    try {
      querySnapshot =
          await _destination.where('userId', isEqualTo: userId).get();
      setState(() {
        destinationList = querySnapshot.docs;
      });
    } catch (e) {
      print("Error querying Firestore: $e");
    }

    setState(() {
      print("User ID: $userId");
      print("Collection Reference: $_destination");

      // Retrieve and store the documents in the destinationList
      // Display the appropriate Scaffold based on the condition
      if (destinationList.isNotEmpty) {
        // Display Scaffold
        print("Displaying Scaffold ${destinationList}");
      } else {
        // Display Scaffold2
        print("Displaying Scaffold2");
      }

      print("Number of destinations found: ${destinationList.length}");

      for (DocumentSnapshot document in destinationList) {
        print("Destination ID: ${document.id}");
        print("Destination Data: ${document.data()}");
      }
    });
  }

  // Function to delete a document
  void deleteDocument(String documentId) {
    FirebaseFirestore.instance
        .collection('Destination')
        .doc(documentId)
        .delete()
        .then((value) {
      // Document successfully deleted
      print('Document with ID $documentId deleted');
      // You may want to refresh the list of destinations after deleting
      refreshDestinations();
    }).catchError((error) {
      // Error occurred while deleting the document
      print('Error deleting document: $error');
    });
  }

  // Function to refresh the list of destinations after deletion
  void refreshDestinations() async {
    try {
      QuerySnapshot querySnapshot =
          await _destination.where('userId', isEqualTo: userId).get();
      setState(() {
        destinationList = querySnapshot.docs;
      });
    } catch (e) {
      print("Error querying Firestore: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (destinationList.isNotEmpty) {
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
                    height: 650,
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: destinationList.length,
                      itemBuilder: (context, index) {
                        final destination = destinationList[index];
                        // print("Destination Data:, ${destination.data()}");
                        final String imagePath =
                            destination['destinationImage1'];
                        final heading = destination['destinationName'];
                        final subtitle = destination['streetName'];
                        return CustomCardWithImage(
                          imagePath: imagePath,
                          imageWidth: 100,
                          imageHeight: 150,
                          cardHeight: 200,
                          heading: heading,
                          subtitle: subtitle,
                          onPress1: () {},
                          onPress2: () {
                            final String destinationName =
                                destination['destinationName'];
                            final String streetNo = destination['streetNo'];
                            final String streetName = destination['streetName'];
                            final String city = destination['city'];
                            final String weekstartTime =
                                destination['weekstartTime'];
                            final String weekendTime =
                                destination['weekendTime'];
                            final String weekendstartTime =
                                destination['weekendstartTime'];
                            final String weekendendTime =
                                destination['weekendendTime'];
                            final String description =
                                destination['description'];
                            final String location = destination['location'];
                            final String destinationImage1 =
                                destination['destinationImage1'];
                            final String destinationImage2 =
                                destination['destinationImage2'];
                            final String cardNo = destination['cardNo'];
                            final String expiryDate = destination['expiryDate'];
                            final String csv = destination['csv'];
                            final String token = destination['token'];
                            final String userId = destination['userId'];

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateDestination(
                                  destinationName: destinationName,
                                  streetNo: streetNo,
                                  streetName: streetName,
                                  city: city,
                                  weekstartTime: weekstartTime,
                                  weekendTime: weekendTime,
                                  weekendstartTime: weekendstartTime,
                                  weekendendTime: weekendendTime,
                                  description: description,
                                  location: location,
                                  destinationImage1: destinationImage1,
                                  destinationImage2: destinationImage2,
                                  cardNo: cardNo,
                                  expiryDate: expiryDate,
                                  csv: csv,
                                  token: token,
                                  userId: userId,
                                  documentId: destination.id,
                                ),
                              ),
                            );
                          },
                          onPress3: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Confirm Deletion'),
                                  content: const Text(
                                      'Are you sure you want to delete this destination?'),
                                  actions: <Widget>[
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        deleteDocument(destination.id);
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                    )),
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: const DestinationBottomNav(),
      );
    } else {
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
                  margin: const EdgeInsets.only(top: 20),
                  child: const Text(
                    'Welcome',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold, // Make the text bold
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Container(
                  width: 360, // Adjust width as needed
                  height: 150, // Set marginTop as needed
                  margin:
                      const EdgeInsets.only(top: 20), // Set marginTop as needed
                  child: const Text(
                    'Your Posted destinations would be displayed here',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center, // Align the text to the center
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 4),
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
              ],
            ),
          ),
        ),
        backgroundColor: Colors.black,
        bottomNavigationBar: const DestinationBottomNav(),
      );
    }
  }
}
