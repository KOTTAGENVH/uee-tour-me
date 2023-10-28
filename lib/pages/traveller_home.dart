import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TouristHome extends StatefulWidget {
  static const String routeName = '/tourist';
  const TouristHome({Key? key}) : super(key: key);

  @override
  State<TouristHome> createState() => _TouristHomeState();
}

class _TouristHomeState extends State<TouristHome> {
  late SecureSharedPref pref;
  late String? userId = '';
  late String userName = '';

  @override
  void initState() {
    super.initState();
    _initPref();
  }

  final CollectionReference _touristHistory =
      FirebaseFirestore.instance.collection('Route-History');

  final CollectionReference _tourist =
      FirebaseFirestore.instance.collection('user');

  Future<void> _initPref() async {
    try {
      pref = await SecureSharedPref.getInstance();
      userId = await pref.getString(MyPrefTags.userId, isEncrypted: true);
      print('uid $userId');
      DocumentSnapshot userSnapshot = await _tourist.doc(userId).get();
      userName = userSnapshot['first_name'];
      print(userName);
    } catch (e) {
      // Handle the error, log it, or show an error message
      print('Error initializing preferences: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initPref(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (userId!.isEmpty) {
            return const CircularProgressIndicator();
          }
          return Scaffold(
            appBar: const TopNav(),
            body: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    'Welcome, $userName',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: _touristHistory
                        .where('userId', isEqualTo: userId)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
                        if (streamSnapshot.data!.docs.isEmpty) {
                          // Display image and text when there is no route history
                          return Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset(
                                  MyImages.traveller,
                                  width: 350,
                                ), // Replace with your image asset
                                const SizedBox(height: 15),
                                const Text(
                                  'Start your first trip now',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                              ],
                            ),
                          );
                        }

                        return ListView.builder(
                          padding: const EdgeInsets.all(4),
                          itemCount: streamSnapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final DocumentSnapshot documentSnapshot =
                                streamSnapshot.data!.docs[index];
                            return GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (context) =>
                                //             ShopProfile(shopId: shopId)));
                              },
                              child: SizedBox(
                                height: 100,
                                child: Card(
                                  color: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: Colors.white),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  margin: const EdgeInsets.all(4),
                                  child: ListTile(
                                    title: buildRow(documentSnapshot),
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }

                      // Display loading indicator while fetching data
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            bottomNavigationBar: const BottomNav(),
          );
        } else {
          // Show loading indicator while waiting for initialization
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildRow(DocumentSnapshot documentSnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          documentSnapshot['name'],
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ],
    );
  }
}
