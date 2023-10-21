import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/souvenirShopAdd.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class ShopProfile extends StatefulWidget {
  final String shopId;

  const ShopProfile({super.key, required this.shopId});

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

final CollectionReference _souvenir =
    FirebaseFirestore.instance.collection('Souvenir');

class _ShopProfileState extends State<ShopProfile> {
  String shopName = '';
  String shopDescription = '';
  String shopAddress = '';
  bool isSaveEnabled = false;

  @override
  void initState() {
    super.initState();
    // Fetch shop details when the widget is initialized
    fetchShopDetails();
  }

  Future<void> fetchShopDetails() async {
    try {
      DocumentSnapshot shopSnapshot = await _souvenir.doc(widget.shopId).get();

      if (shopSnapshot.exists) {
        setState(() {
          // Update the state with the shop details
          shopName = shopSnapshot['shopName'];
          shopDescription = shopSnapshot['description'];
          shopAddress = shopSnapshot['address'];

          // Set the initial values for the text controllers
          _nameController.text = shopName;
          _addressController.text = shopAddress;
          _descriptionController.text = shopDescription;
        });
      } else {
        // Handle the case where the shop document doesn't exist
      }
    } catch (e) {
      // Handle any errors that might occur during fetching
      print('Error fetching shop details: $e');
    }
  }

  Future<void> saveChanges() async {
    try {
      await _souvenir.doc(widget.shopId).update({
        'shopName': _nameController.text,
        'description': _descriptionController.text,
        'address': _addressController.text,
      });
    } catch (e) {
      // Handle errors during saving
      print('Error saving changes: $e');
    }
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
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: [
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Shop name',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.store,
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
                    onChanged: (value) {
                      setState(() {
                        isSaveEnabled = true;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.only(left: 5),
                        child: PinkButton(
                          onPress: () {
                            // Handle Add Image
                          },
                          text: 'Change Location on map',
                          icon: const Icon(Icons.location_pin,
                              color: Colors.white),
                        ),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.location_on,
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
                    onChanged: (value) {
                      setState(() {
                        isSaveEnabled = true;
                      });
                    },
                    style: const TextStyle(color: Colors.white),
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.note,
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
                    maxLines: 4,
                    onChanged: (value) {
                      setState(() {
                        isSaveEnabled = true;
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isSaveEnabled
                        ? () async {
                            // Handle the asynchronous logic here
                            await saveChanges();
                            setState(() {
                              isSaveEnabled = false;
                            });
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.pink, // Change the button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Set border radius
                      ),
                      fixedSize:
                          const Size(100, 40), // Set button width and height
                    ),
                    child: const Center(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('SAVE'),
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      PinkButton(
                        onPress: () {
                          // Handle Add Image
                        },
                        text: 'Product List',
                        icon: const Icon(Icons.list, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      PinkButton(
                        onPress: () {
                          // Handle Add Location
                        },
                        text: 'Add Product',
                        icon: const Icon(Icons.production_quantity_limits,
                            color: Colors.white),
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
