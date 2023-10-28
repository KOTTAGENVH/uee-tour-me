import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/card.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TravellerHome extends StatefulWidget {
  static const String routeName = '/travelerHome';
  const TravellerHome({Key? key}) : super(key: key);

  @override
  State<TravellerHome> createState() => _TravellerHomeState();
}

class _TravellerHomeState extends State<TravellerHome> {
  final CollectionReference _touristHistory = FirebaseFirestore.instance.collection('Route-History');
  late SecureSharedPref pref;
  late String userId;

  @override
  void initState() {
    super.initState();
    _postInit();
  }

  Future<void> _postInit() async {
    pref = await SecureSharedPref.getInstance();

    // Fetch the user's ID from SharedPreferences
    String? id = await pref.getString(MyPrefTags.userId, isEncrypted: true);

    // Fetch user data from Firestore based on the user's ID
    if (id != null) {
      var query = _touristHistory.where('userId', isEqualTo: id);
      QuerySnapshot querySnapshot = await query.get();
      List<QueryDocumentSnapshot> documents = querySnapshot.docs;

      // You can now work with the documents to display user data
      for (var document in documents) {
        print(document['name']);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    try {
      return Scaffold(
        appBar: const TopNav(),
        bottomNavigationBar: const BottomNav(selcted: Selections.home),
        body: Container(
          decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
          padding: const EdgeInsets.all(10),
          child: const Center(
            child: Text(
              'Lets create our first Trip',
              style: TextStyle(color: Colors.white),
            ),
          ),
          // child: ListView.builder(
          //   itemCount: 3,
          //   itemBuilder: (context, index) {
          //     return CustomCardWithImage(
          //       heading: 'Head',
          //       subtitle: 'sub',
          //       imagePath: 'https://i.redd.it/apy63yumihw81.jpg',
          //       onPress1: () {},
          //       onPress2: () {},
          //       onPress3: () {},
          //     );
          //   },
          // ),
        ),
      );
    } catch (e, t) {
      print("Error: $e");
      print("StackTrace: $t");
      return const SizedBox.shrink();
    }
  }

  // Example function to build a row from a DocumentSnapshot
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
