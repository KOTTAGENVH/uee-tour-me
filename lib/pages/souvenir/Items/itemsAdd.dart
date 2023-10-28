import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/Items/itemList.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:flutter/services.dart';
import 'package:tour_me/widgets/upload_image_button.dart';
import 'package:tour_me/widgets/upload_image_button2.dart';
import 'package:tour_me/widgets/upload_single_images.dart';

class ItemAdd extends StatefulWidget {
  final String? shopId;

  const ItemAdd({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ItemAdd> createState() => _ItemAddState();
}

class _ItemAddState extends State<ItemAdd> {
  late String shopId;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationImage1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    shopId = widget.shopId ?? '';
    print(shopId);
  }

  final CollectionReference _items =
      FirebaseFirestore.instance.collection('SouvenirItems');
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

  @override
  Widget build(BuildContext context) {
    bool imageUploaded = false;
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
                        Icons.shopping_cart,
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      UploadImageButton2(
                        onPress: () async {
                          String? imageUrl = await ImageUpload.save(context);
                          print("url $imageUrl");
                          if (imageUrl!.isNotEmpty) {
                            setState(() {
                              imageUploaded = true;
                              _locationImage1.text = imageUrl;
                            });
                            print('urls: $imageUrl');
                            print('Image1: ${_locationImage1.text}');
                            print('imageUploaded = $imageUploaded');
                            showImageUploadToast(
                                'Successfully Uploaded Images', true);
                          }
                          if (imageUrl.isNotEmpty) {
                          } else {
                            // Handle the case where no URLs were returned (e.g., upload failure)
                            showImageUploadToast(
                                'Failed to Upload Image1s', false);
                          }
                        },
                        text: imageUploaded
                            // ignore: dead_code
                            ? 'Shop Image! uploaded \u2713'
                            : '📷 Shop Image',
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
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
                        Icons.price_change,
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
                  ),
                  const SizedBox(height: 30),
                  PinkButton(
                    onPress: () async {
                      final String name = _nameController.text;
                      final String price = _priceController.text;
                      final String description = _descriptionController.text;
                      if (name.isNotEmpty &&
                          price.isNotEmpty &&
                          description.isNotEmpty) {
                        try {
                          // Update the shop's document with the new product
                          await _items.add({
                            'shopId': widget.shopId,
                            'productName': name,
                            'price': price,
                            'description': description,
                            'image': _locationImage1.text
                          });

                          _nameController.text = '';
                          _priceController.text = '';
                          _descriptionController.text = '';
                          // ignore: use_build_context_synchronously
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Shop added successfully!'),
                              backgroundColor: Colors.green,
                            ),
                          );
                          // Navigate to the home page or wherever you want to go
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemList(shopId: widget.shopId ?? ''),
                            ),
                          );
                        } catch (e) {
                          // Handle errors
                          print('Error adding product: $e');
                        }
                      } else {
                        // Show an error message if any of the fields is empty
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Please fill in all fields.'),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    },
                    text: 'ADD',
                    icon: const Icon(Icons.add, color: Colors.white),
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
