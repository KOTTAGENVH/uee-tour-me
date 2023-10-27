import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/pages/souvenir/payment/shopAddPay.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class CreditCardPay extends StatefulWidget {
  final double totalPay;
  final List<String> selectedIds;
  final String userId;
  const CreditCardPay(
      {Key? key,
      required this.totalPay,
      required this.selectedIds,
      required this.userId})
      : super(key: key);

  @override
  _CreditCardPayState createState() => _CreditCardPayState();
}

class _CreditCardPayState extends State<CreditCardPay> {
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _totalPriceController = TextEditingController();
  DateTime? selectedDate;

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');
  final CollectionReference _souvenirpayment =
      FirebaseFirestore.instance.collection('SouvenirPayment');

  Future<void> updateLastMonthlyPayDate(List<String> selectedIds) async {
    try {
      for (String id in selectedIds) {
        await _souvenir.doc(id).update({
          "lastMonthlyPayDate": DateTime.now(),
        });
        print('Updated lastMonthlyPayDate for shop with id: $id');
      }
    } catch (e) {
      print('Error updating lastMonthlyPayDate: $e');
    }
  }

  Future<List<String>> getShopNames(List<String> shopIds) async {
    List<String> shopNames = [];

    for (String id in shopIds) {
      DocumentSnapshot shopSnapshot = await _souvenir.doc(id).get();

      if (shopSnapshot.exists) {
        // Cast data to Map<String, dynamic>
        Map<String, dynamic>? shopData =
            shopSnapshot.data() as Map<String, dynamic>?;

        // Assuming there's a 'name' field in your shop document
        String shopName = shopData?['shopName'] ?? 'Unknown Shop';
        shopNames.add(shopName);
      } else {
        shopNames.add('Unknown Shop');
      }
    }

    return shopNames;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('Form', style: TextStyle(fontSize: 25)),
          centerTitle: true,
          backgroundColor: Colors.black,
          actions: [
            Container(
              margin: const EdgeInsets.only(right: 10),
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white.withOpacity(0.5),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              MyImages.creditCard,
              height: 120, // Set the desired height
              width: 120, // Set the desired width
            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  Text(
                    'Total \t\t ${widget.totalPay}', // Use widget.totalPay
                    style: const TextStyle(color: Colors.white, fontSize: 18.0),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Card Holder's name",
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Card No',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.credit_card,
                        color: Colors.white,
                      ),
                      filled: true,
                      fillColor: const Color(0xFF454452),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.white),
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          readOnly: true,
                          controller: TextEditingController(
                            text: selectedDate != null
                                ? "${selectedDate!.day}/${selectedDate!.month}/${selectedDate!.year}"
                                : "",
                          ),
                          decoration: InputDecoration(
                            labelText: 'Expiry Date',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.date_range,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF454452),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(DateTime.now().year + 10),
                            );

                            if (pickedDate != null &&
                                pickedDate != selectedDate) {
                              setState(() {
                                selectedDate = pickedDate;
                              });
                            }
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'CVC',
                            labelStyle: const TextStyle(color: Colors.white),
                            prefixIcon: const Icon(
                              Icons.security,
                              color: Colors.white,
                            ),
                            filled: true,
                            fillColor: const Color(0xFF454452),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment
                        .spaceBetween, // Align buttons to the start and end of the row
                    children: [
                      PinkButton(
                        onPress: () async {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ShopAddPay(),
                            ),
                          );
                        },
                        text: '',
                        icon: const Icon(Icons.arrow_circle_left_sharp,
                            color: Colors.white),
                      ),
                      PinkButton(
                        onPress: () async {
                          List<String> shopNames =
                              await getShopNames(widget.selectedIds);

                          await _souvenirpayment.add({
                            "userId": widget.userId,
                            "Date": DateTime,
                            "shops": shopNames,
                            "totalPrice": widget.totalPay,
                          });
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SouvenirHomePage(),
                            ),
                          );

                          await updateLastMonthlyPayDate(widget.selectedIds);
                        },
                        text: 'PAY',
                        icon: const Icon(Icons.payment, color: Colors.white),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomNav2(),
    );
  }
}
