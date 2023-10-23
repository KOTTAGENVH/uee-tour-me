import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class ItemProfile extends StatefulWidget {
  final String productIndex;
  final String shopId;
  const ItemProfile(
      {super.key, required this.productIndex, required this.shopId});

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

  late String productId = widget.productIndex;

  late CollectionReference _souvenir;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _priceController = TextEditingController();
    _descriptionController = TextEditingController();

    // Initialize _souvenir with the specific collection reference based on shopId
    _souvenir = FirebaseFirestore.instance.collection('Souvenir');

    // Fetch product details when the widget is initialized
    fetchProductDetails();
  }

  Future<void> fetchProductDetails() async {
    try {
      DocumentSnapshot shopSnapshot = await _souvenir.doc(widget.shopId).get();

      // Check if the document exists and has data
      if (shopSnapshot.exists) {
        // Access the data as a Map
        Map<String, dynamic>? data =
            shopSnapshot.data() as Map<String, dynamic>?;

        // Check if data is not null and if the array field exists
        if (data != null && data.containsKey('products')) {
          // Access the products data
          dynamic productsData = data['products'];

          if (productsData is List<dynamic>) {
            // Handle it as a List
            if (productsData.isNotEmpty) {
              // You might want to handle the case when the list is not empty
              // For now, let's take the first item
              var desiredObject = productsData[int.parse(productId)];
              setState(() {
                // Update the state with the product details
                productName = desiredObject['productName'];
                productDescription = desiredObject['description'];
                productPrice = desiredObject['price'];

                // Set the initial values for the text controllers
                _nameController.text = productName;
                _priceController.text = productPrice;
                _descriptionController.text = productDescription;
              });
            } else {
              print('Products list is empty');
            }
          } else if (productsData is Map<String, dynamic>) {
            // Handle it as a Map
            Map<String, dynamic> productsMap = productsData;
            if (productsMap.isNotEmpty) {
              var desiredObject = productsMap[productId];
              print('asfdas $productId');
              print(productId);
              setState(() {
                // Update the state with the product details
                productName = desiredObject['productName'];
                productDescription = desiredObject['description'];
                productPrice = desiredObject['price'];

                // Set the initial values for the text controllers
                _nameController.text = productName;
                _priceController.text = productPrice;
                _descriptionController.text = productDescription;
              });
            } else {
              print('Products map is empty');
            }
          }
        } else {
          print('Products field not found in document or data is null');
        }
      } else {
        print('Document does not exist');
      }
    } catch (e) {
      // Handle any errors that might occur during fetching
      print('Error fetching product details: $e');
    }
  }

  Future<void> saveChanges() async {
    try {
      var updatedProduct = {
        'productName': _nameController.text,
        'description': _descriptionController.text,
        'price': _priceController.text,
      };

      // Construct the update using FieldValue
      var update = {
        'products.$productId': updatedProduct,
      };

      await _souvenir.doc(widget.shopId).update(update);
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
