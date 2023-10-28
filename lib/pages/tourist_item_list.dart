// ignore_for_file: unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/Items/ItemProfile.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TouristItemList extends StatefulWidget {
  final String shopId;
  // final String shopName;

  const TouristItemList({Key? key, required this.shopId}) : super(key: key);

  @override
  State<TouristItemList> createState() => _TouristItemListState();
}

class _TouristItemListState extends State<TouristItemList> {
  late String shopId;

  final CollectionReference _souvenir = FirebaseFirestore.instance.collection('Souvenir');

  final CollectionReference _items = FirebaseFirestore.instance.collection('SouvenirItems');

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopNav(),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _items.where('shopId', isEqualTo: widget.shopId).snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
                if (streamSnapshot.hasData) {
                  if (streamSnapshot.data!.docs.isEmpty) {
                    // Display a message when there are no products
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            MyImages.items,
                            width: 350,
                          ),
                          const SizedBox(height: 8.0),
                        ],
                      ),
                    );
                  } else {
                    // Display the product list
                    return ListView.builder(
                      padding: const EdgeInsets.all(4),
                      itemCount: streamSnapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final DocumentSnapshot documentSnapshot = streamSnapshot.data!.docs[index];
                        String productId = documentSnapshot.reference.id;
                        return SizedBox(
                          height: 100,
                          child: Card(
                            color: Colors.black,
                            shape: RoundedRectangleBorder(
                              side: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(4),
                            child: ListTile(
                              title: buildProductCard(documentSnapshot),
                            ),
                          ),
                        );
                      },
                    );
                  }
                } else {
                  // Display a loading indicator while data is loading
                  return const Center(child: CircularProgressIndicator());
                }
              },
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Widget buildProductCard(DocumentSnapshot documentSnapshot) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          documentSnapshot['productName'],
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
        Text(
          documentSnapshot['price'],
          style: const TextStyle(color: Colors.white, fontSize: 25),
        ),
      ],
    );
  }

  Widget buildProductTile(Map<String, dynamic> product, int index) {
    print(index);
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ItemProfile(
              productId: index.toString(),
              shopId: shopId,
            ),
          ),
        );
      },
      child: SizedBox(
        height: 80,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(4),
          child: Row(
            children: [
              Text(
                '    ${product['productName']}',
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              const Spacer(),
              Text(
                'Rs. ${product['price']}    ',
                style: const TextStyle(
                  color: Colors.greenAccent,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
