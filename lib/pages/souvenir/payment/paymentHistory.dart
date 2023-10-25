import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/pages/souvenir/shopProfile.dart';
import 'package:tour_me/pages/souvenir/payment/shopAddPay.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class PaymentHistory extends StatefulWidget {
  const PaymentHistory({super.key});

  @override
  State<PaymentHistory> createState() => _PaymentHistoryState();
}

class _PaymentHistoryState extends State<PaymentHistory> {
  final CollectionReference _souvenirpayment =
      FirebaseFirestore.instance.collection('SouvenirPayment');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 10, top: 24, right: 10, bottom: 4),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _souvenirpayment.snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  return ListView.builder(
                    padding: const EdgeInsets.all(4), // Reduce padding here
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return buildRow(documentSnapshot);
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
    List<dynamic> shopNames = documentSnapshot['shops'];
    double totalPrice = documentSnapshot['totalPrice'];

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.pink), // Pink border
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(8), // Margin for the entire card
          child: Padding(
            padding: const EdgeInsets.all(
                8), // Padding for the content inside the card
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the left
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      (documentSnapshot['Date'] as Timestamp)
                          .toDate()
                          .toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  ],
                ),
                const SizedBox(
                    height: 8), // Adjust the space between date and text
                const Text(
                  'Shops', // Your heading or title
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                    height: 8), // Adjust the space between text and shop list
                Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start, // Align text to the left
                  children: shopNames.map((shopName) {
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 16.0),
                          child: Text(
                            '•',
                            style: TextStyle(color: Colors.pink, fontSize: 16),
                          ),
                        ),
                        const SizedBox(width: 15),
                        Text(
                          shopName.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 16),
                        ),
                      ],
                    );
                  }).toList(),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Price', // Your additional text after the shops
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    Text(
                      totalPrice.toString(), // Assuming totalPrice is a list
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
