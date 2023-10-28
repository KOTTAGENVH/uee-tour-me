import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/shopProfile.dart';
import 'package:tour_me/pages/souvenir/payment/shopAddPay.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:tour_me/widgets/top_nav.dart';

class SouvenirHomePage extends StatefulWidget {
  static const String routeName = '/souvinirhome';

  const SouvenirHomePage({super.key});

  @override
  State<SouvenirHomePage> createState() => _SouvenirHomePageState();
}

class _SouvenirHomePageState extends State<SouvenirHomePage> {
  late SecureSharedPref pref;
  late String? userId;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _initPref() async {
    pref = await SecureSharedPref.getInstance();
    userId = await pref.getString(MyPrefTags.userId, isEncrypted: true);
    print('uid $userId');
  }

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

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
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, top: 24, right: 10, bottom: 4),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      PinkButton(
                        onPress: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopAddPay(),
                            ),
                          );
                        },
                        text: 'PAY',
                        icon: const Icon(Icons.payment, color: Colors.white),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: StreamBuilder(
                    stream: _souvenir
                        .where('userId', isEqualTo: userId)
                        .snapshots(),
                    builder:
                        (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                      if (streamSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (streamSnapshot.hasError) {
                        return const Center(
                          child: Text('Error loading shops'),
                        );
                      } else if (streamSnapshot.data!.docs.isEmpty) {
                        // Display image and text when there are no shops
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(MyImages.emptyShops),
                              const SizedBox(
                                height:
                                    8.0, // Provide a double value for height
                              ),
                              const Text(
                                'Get Started.',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 24),
                              ),
                              const SizedBox(
                                height:
                                    4.0, // Provide a double value for height
                              ),
                              const Text(
                                'Add your first shop here',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        );
                      } else {
                        // Continue with the existing logic when there are shops
                        return Expanded(
                          child: ListView.builder(
                            padding: const EdgeInsets.all(4),
                            itemCount: streamSnapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              final DocumentSnapshot documentSnapshot =
                                  streamSnapshot.data!.docs[index];
                              String shopId = documentSnapshot.reference.id;
                              return GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShopProfile(shopId: shopId)),
                                  );
                                },
                                child: SizedBox(
                                  height: 100,
                                  child: Card(
                                    color: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      side:
                                          const BorderSide(color: Colors.white),
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
                          ),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
            backgroundColor: Colors.black,
            bottomNavigationBar: const BottomNav2(selected: Selections.home),
          );
        } else {
          // Show loading indicator while waiting for initialization
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget buildRow(DocumentSnapshot documentSnapshot) {
    DateTime prevDate = documentSnapshot['lastMonthlyPayDate'].toDate();
    DateTime currentDate = DateTime.now();

    // Calculate the difference in days
    int daysDifference = currentDate.difference(prevDate).inDays;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          documentSnapshot['shopName'],
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          daysDifference < 30 ? 'Active' : 'Inactive',
          style: TextStyle(
            color: daysDifference < 30 ? Colors.green : Colors.red,
            fontWeight:
                daysDifference < 30 ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
