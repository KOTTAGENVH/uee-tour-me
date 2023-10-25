import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/pages/souvenir/shopProfile.dart';
import 'package:tour_me/pages/souvenir/payment/shopAddPay.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class SouvenirHomePage extends StatefulWidget {
  const SouvenirHomePage({super.key});

  @override
  State<SouvenirHomePage> createState() => _SouvenirHomePageState();
}

class _SouvenirHomePageState extends State<SouvenirHomePage> {
  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 24, right: 10, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PinkButton(
                  onPress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ShopAddPay()),
                    );
                  },
                  text: 'PAY',
                  icon: const Icon(Icons.payment, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _souvenir.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(4), // Reduce padding here
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
                                      ShopProfile(shopId: shopId)));
                        },
                        child: SizedBox(
                          height: 100,
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin:
                                const EdgeInsets.all(4), // Reduce margin here
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
      bottomNavigationBar: const BottomNav2(),
    );
  }

  Widget buildRow(DocumentSnapshot documentSnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          documentSnapshot['shopName'],
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          documentSnapshot['isActive'] == true ? 'Active' : 'Inactive',
          style: TextStyle(
            color: documentSnapshot['isActive'] == true
                ? Colors.green
                : Colors.red,
            fontWeight: documentSnapshot['isActive'] == true
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ],
    );
  }
}
