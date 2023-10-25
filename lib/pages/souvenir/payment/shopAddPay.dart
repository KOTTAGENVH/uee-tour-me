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
  List<Map<String, String>> shopDetail = [];
  List<String> selectedShopIds = [];

  int shopNameLength = 0;
  static const double payment = 499.00;

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

  late QuerySnapshot querySnapshot;
  @override
  void initState() {
    super.initState();
    _loadshopDetail();
    shopNameLength = selectedShopIds.length;
  }

  Future<void> _loadshopDetail() async {
    try {
      querySnapshot = await _souvenir.get();
      List<Map<String, String>> names = [];

      DateTime currentDate = DateTime.now();

      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        String docId = doc.reference.id;
        print('$selectedShopIds');
        Timestamp lastPayDateTimestamp = doc['lastMonthlyPayDate'];
        DateTime lastPayDate = lastPayDateTimestamp.toDate();

        // Calculate the difference in days
        int daysDifference = currentDate.difference(lastPayDate).inDays;

        print('$daysDifference');

        if (daysDifference > 30) {
          // Assuming 'shopName' is the field in the document
          String shopName = doc['shopName'];
          names.add({'docId': docId, 'shopName': shopName});
        }
      }

      setState(() {
        shopDetail = names;
      });
    } catch (e) {
      print('Error loading shop names: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('$shopNameLength');

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
              Column(
                children: [
                  for (Map<String, String> shop in shopDetail)
                    _buildCheckboxListTile(shop['shopName']!, shop['docId']!),
                ],
              ),
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
                          builder: (context) => CreditCardPay(
                                totalPay: totalPay,
                                selectedIds: selectedShopIds,
                              )));
                },
                text: 'PAY',
                icon: const Icon(Icons.payment, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomNav2(),
    );
  }

  Widget _buildCheckboxListTile(String shopName, String docId) {
    return ListTile(
      title: Text(
        shopName,
        style: const TextStyle(color: Colors.white),
      ),
      leading: Checkbox(
        value: selectedShopIds.contains(docId),
        activeColor: Colors.pink,
        side: MaterialStateBorderSide.resolveWith(
          (states) => const BorderSide(width: 1.0, color: Colors.red),
        ),
        onChanged: (value) {
          setState(() {
            if (value != null) {
              if (value) {
                selectedShopIds.add(docId);
              } else {
                selectedShopIds.remove(docId);
              }
            }
            shopNameLength = selectedShopIds.length;
          });
        },
      ),
    );
  }
}
