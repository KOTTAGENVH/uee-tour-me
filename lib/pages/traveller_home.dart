import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/pink_button.dart';

class TouristHome extends StatefulWidget {
  const TouristHome({Key? key}) : super(key: key);

  @override
  State<TouristHome> createState() => _TouristHomeState();
}

class _TouristHomeState extends State<TouristHome> {
  late SecureSharedPref pref;
  late String? userId = '';

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initPref() async {
    pref = await SecureSharedPref.getInstance();
    userId = await pref.getString(MyPrefTags.userId, isEncrypted: true);
    print('uid $userId');
  }

  final CollectionReference _touristHistory =
      FirebaseFirestore.instance.collection('Route-History');

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
            body: Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: _touristHistory
                        .where('userId', isEqualTo: userId)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.hasData) {
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
