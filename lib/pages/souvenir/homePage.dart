import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';

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
      body: StreamBuilder(
          stream: _souvenir.snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
            //streamSnapshot contains the data
            if (streamSnapshot.hasData) {
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length, //number of rows
                  itemBuilder: (context, index) {
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return InkWell(
                        onTap: () {
                          print(
                              'Card Clicked: ${documentSnapshot['shopName']}');
                        },
                        child: SizedBox(
                            height: 100,
                            child: Card(
                                color: Colors
                                    .black, // Set card background color to black
                                shape: RoundedRectangleBorder(
                                  // Set card border to white
                                  side: const BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                margin: const EdgeInsets.all(10),
                                child: ListTile(
                                  title: buildRow(documentSnapshot),
                                ))));
                  });
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
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
