import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';

class ItemProfile extends StatefulWidget {
  final String productId;
  final String shopId;
  const ItemProfile({super.key, required this.productId, required this.shopId});

  @override
  State<ItemProfile> createState() => _ItemProfileState();
}

late TextEditingController _nameController;
late TextEditingController _priceController;
late TextEditingController _descriptionController;

class _ItemProfileState extends State<ItemProfile> {
  String productName = '';
  String productPrice = '';
  String productDescription = '';
  bool isSaveEnabled = false;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();

  late String productId = widget.productId;

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('SouvenirItems');

  @override
  void initState() {
    super.initState();
    // Fetch product details when the widget is initialized
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      DocumentSnapshot shopSnapshot = await _items.doc(widget.productId).get();

      if (shopSnapshot.exists) {
        setState(() {
          // Update the state with the shop details
          productName = shopSnapshot['productName'];
          productDescription = shopSnapshot['description'];
          productPrice = shopSnapshot['price'];

          // Set the initial values for the text controllers
          _nameController.text = productName;
          _priceController.text = productPrice;
          _descriptionController.text = productDescription;
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
      if (_nameController.text.isEmpty ||
          _priceController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      await _items.doc(widget.productId).update({
        'productName': _nameController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
      });
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Changes saved successfully!'),
          backgroundColor: Colors.green,
        ),
      );
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
                      labelText: 'Product name',
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
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _priceController,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                          RegExp(r'^\d+\.?\d{0,2}$'))
                    ],
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    decoration: InputDecoration(
                      labelText: 'Price',
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
