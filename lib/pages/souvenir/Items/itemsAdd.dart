import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/souvenir/Items/itemList.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

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

  @override
  void initState() {
    super.initState();
    shopId = widget.shopId ?? '';
    print(shopId);
  }

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

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
                      PinkButton(
                        onPress: () {
                          // Handle Add Image
                        },
                        text: 'Add Image',
                        icon:
                            const Icon(Icons.add_a_photo, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                  const SizedBox(height: 20),
                  TextFormField(
                    controller: _priceController,
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
                          await _souvenir.doc(widget.shopId).update({
                            'products': FieldValue.arrayUnion([
                              {
                                'productName': name,
                                'price': price,
                                'description': description,
                              }
                            ]),
                          });

                          _nameController.text = '';
                          _priceController.text = '';
                          _descriptionController.text = '';

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
