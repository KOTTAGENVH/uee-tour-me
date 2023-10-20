import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/pages/souvenir/payment/creditCardPay.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class ShopAddPay extends StatefulWidget {
  const ShopAddPay({Key? key}) : super(key: key);

  @override
  State<ShopAddPay> createState() => _ShopAddPayState();
}

class _ShopAddPayState extends State<ShopAddPay> {
  List<String> shopNames = [];

  static const double payment = 499.00;

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

  @override
  void initState() {
    super.initState();
    _loadShopNames();
  }

  Future<void> _loadShopNames() async {
    try {
      QuerySnapshot querySnapshot = await _souvenir.get();
      List<String> names = [];

      DateTime currentDate = DateTime.now();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        // Assuming 'lastMonthlyPayDate' is a Timestamp field
        Timestamp lastPayDateTimestamp = doc['lastMonthlyPayDate'];
        DateTime lastPayDate = lastPayDateTimestamp.toDate();

        // Calculate the difference in days
        int daysDifference = currentDate.difference(lastPayDate).inDays;

        print('$daysDifference');

        if (daysDifference > 30) {
          // Assuming 'shopName' is the field in the document
          String shopName = doc['shopName'];
          names.add(shopName);
        }
      }

      setState(() {
        shopNames = names;
      });
    } catch (e) {
      print('Error loading shop names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    int shopNameLength = shopNames.length;

    double totalPay = shopNameLength * payment;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          child: Column(
            children: [
              const Text(
                'Pic shops for monthly \nPayment',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8.0),
              for (String shopName in shopNames)
                _buildCheckboxListTile(shopName),
              const SizedBox(height: 16.0),
              Text(
                '$payment * ${shopNameLength ?? 0}',
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              Text(
                'Total Payment(Rs. ) \t\t $totalPay',
                style: const TextStyle(color: Colors.white, fontSize: 18.0),
              ),
              PinkButton(
                onPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            CreditCardPay(totalPay: totalPay)),
                  );
                },
                text: 'PAY',
                icon: const Icon(Icons.payment, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.pink,
      bottomNavigationBar: const BottomNav2(),
    );
  }

  Widget _buildCheckboxListTile(String shopName) {
    return ListTile(
      title: Text(
        shopName,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Checkbox(
        value: false, // You can set the initial value as needed
        activeColor: Colors.white,
        onChanged: (value) {
          // Handle checkbox state changes
        },
      ),
    );
  }
}
