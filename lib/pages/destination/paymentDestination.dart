import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:secure_shared_preferences/secure_shared_pref.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/destination/addDestination.dart';
import 'package:tour_me/widgets/destination_owner_bottom_nav.dart';
import 'package:tour_me/widgets/message_popup.dart';
import 'package:tour_me/widgets/next_back_button.dart';
import 'package:tour_me/widgets/upload_image_button.dart';
import 'package:tour_me/widgets/upload_multiple_images.dart';

class DestinationPayment extends StatefulWidget {
  final String destinationName;
  final String streetNo;
  final String streetName;
  final String city;
  final String weekstartTime;
  final String weekendTime;
  final String weekendstartTime;
  final String weekendendTime;
  final String description;
  final String location;
  final String destinationImage1;
  final String destinationImage2;

  const DestinationPayment({
    super.key,
    required this.destinationName,
    required this.streetNo,
    required this.streetName,
    required this.city,
    required this.weekstartTime,
    required this.weekendTime,
    required this.weekendstartTime,
    required this.weekendendTime,
    required this.description,
    required this.location,
    required this.destinationImage1,
    required this.destinationImage2,
  });

  @override
  void initState() {
    initSecureSharedPref();
  }

  Future<void> initSecureSharedPref() async {
    var pref = await SecureSharedPref.getInstance();
    pref.getString(MyPrefTags.userId, isEncrypted: true);
  }

  static const String routeName = '/makeDestinationPayment';

  @override
  State<DestinationPayment> createState() => _DestinationPaymentState();
}

class _DestinationPaymentState extends State<DestinationPayment> {
  String generateRandomToken() {
    final random = Random();
    final token = random.nextInt(10000);
    return token.toString().padLeft(4, '0');
  }

  final TextEditingController _locationNameController = TextEditingController();
  final TextEditingController _streetNoController = TextEditingController();
  final TextEditingController _streetNameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _weekstartTimeController =
      TextEditingController();
  final TextEditingController _weekendTimeController = TextEditingController();
  final TextEditingController _weekendstartTimeController =
      TextEditingController();
  final TextEditingController _weekendendTimeController =
      TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _locationImage1 = TextEditingController();
  final TextEditingController _locationImage2 = TextEditingController();
  final TextEditingController _cardNumberController = TextEditingController();
  final TextEditingController _csvController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();

  final CollectionReference _destination =
      FirebaseFirestore.instance.collection('Destination');

  void showImageUploadToast(String? imageUrl, bool success) {
    if (imageUrl != null) {
      Fluttertoast.showToast(
        msg: 'Successfully uploaded image: $imageUrl',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Sorry, upload failed.',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

 Future<bool> isTokenUnique(String token) async {
    final querySnapshot = await _destination.where('token', isEqualTo: token).get();
    return querySnapshot.docs.isEmpty;
  }

  // Generate a unique token
  Future<String> generateUniqueToken() async {
    String token;
    do {
      token = generateRandomToken();
    } while (!(await isTokenUnique(token)));
    return token;
  }
  
  @override
  Widget build(BuildContext context) {
    bool imageUploaded = false;
    String getCardType(String cardNumber) {
      // Logic to determine the card type (Visa, MasterCard, etc.)
      if (cardNumber.startsWith('4')) {
        return 'Visa';
      } else if (cardNumber.startsWith('5')) {
        return 'MasterCard';
      } else {
        return 'Unknown';
      }
    }

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          leading: Image.asset(MyImages.iconLogo),
          title: const Text('Make Payment', style: TextStyle(fontSize: 25)),
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
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 360, // Adjust width as needed
              height: 220, // Adjust height as needed
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(20), // Adjust the border radius
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(
                    20), // Same border radius as the container
                child: Image.asset(
                  'assets/images/debitcard.jpg', // Replace with your image path
                  fit: BoxFit
                      .cover, // You can use a different BoxFit to control image scaling
                ),
              ),
            ),
            Container(
              margin:
                  EdgeInsets.only(top: 20), // Adjust the top margin as needed
              child: Text(
                'Amount: Rs. 1000',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
              child: Column(children: [
                TextFormField(
                  controller: _cardNumberController,
                  decoration: InputDecoration(
                    labelText: 'Card Number',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.credit_card,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _csvController,
                  decoration: InputDecoration(
                    labelText: 'CSV',
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.security,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _expiryDateController,
                  decoration: InputDecoration(
                    labelText:
                        'Expiry Date', // Replace "Name on Card" with "Expiry Date"
                    labelStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.calendar_today,
                      color: Colors.white,
                    ),
                    filled: true,
                    fillColor: Color(0xFF454452),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 20),
                NextButton(
                  onPress: () async {
                    final String destinationName = widget.destinationName;
                    final String streetNo = widget.streetNo;
                    final String streetName = widget.streetName;
                    final String city = widget.city;
                    final String weekstartTime = widget.weekstartTime;
                    final String weekendTime = widget.weekendTime;
                    final String weekendstartTime = widget.weekendstartTime;
                    final String weekendendTime = widget.weekendendTime;
                    final String description = widget.description;
                    final String location = widget.location;
                    final String destinationImage1 = widget.destinationImage1;
                    final String destinationImage2 = widget.destinationImage2;
                    final String cardNo = _cardNumberController.text;
                    final String csv = _csvController.text;
                    final String expiryDate = _expiryDateController.text;
                    final String token = await generateUniqueToken();

                    final SecureSharedPref pref =
                        await SecureSharedPref.getInstance();
                    final String? userId = await pref.getString(
                        MyPrefTags.userId,
                        isEncrypted: true) as String?;

                    if (destinationName.isNotEmpty &&
                        streetNo.isNotEmpty &&
                        streetName.isNotEmpty &&
                        city.isNotEmpty &&
                        weekstartTime.isNotEmpty &&
                        weekendTime.isNotEmpty &&
                        weekendstartTime.isNotEmpty &&
                        weekendendTime.isNotEmpty &&
                        description.isNotEmpty &&
                        location.isNotEmpty &&
                        destinationImage1.isNotEmpty &&
                        destinationImage2.isNotEmpty &&
                        cardNo.isNotEmpty &&
                        csv.isNotEmpty &&
                        expiryDate.isNotEmpty) {
                      await _destination
                          .add({
                            "destinationName": destinationName,
                            "streetNo": streetNo,
                            "streetName": streetName,
                            "city": city,
                            "weekstartTime": weekstartTime,
                            "weekendTime": weekendTime,
                            "weekendstartTime": weekendstartTime,
                            "weekendendTime": weekendendTime,
                            "description": description,
                            "location": location,
                            "destinationImage1": destinationImage1,
                            "destinationImage2": destinationImage2,
                            "cardNo": cardNo,
                            "csv": csv,
                            "expiryDate": expiryDate,
                            "token": token,
                            "userId": userId,
                          })
                          .then((value) => MessagePopUp.display(
                                context,
                                title: "Success",
                                icon: const Icon(
                                  Icons.check_circle_outline,
                                  color: Colors.green,
                                ),
                                message: 'Images have been Uploaded',
                              ))
                          .catchError((error) => MessagePopUp.display(
                                context,
                                title: "Error",
                                icon: const Icon(
                                  Icons.error_outline,
                                  color: Colors.red,
                                ),
                                message: 'Failed to upload images: $error',
                              ));
                    } else {
                      MessagePopUp.display(
                        context,
                        title: "Error",
                        icon: const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                        ),
                        message: 'Please fill all the fields',
                      );
                    }
                  },
                  text: 'Pay',
                ),
              ]),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const DestinationBottomNav(),
    );
  }
}
