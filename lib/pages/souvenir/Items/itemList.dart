import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/pages/souvenir/Items/ItemProfile.dart';
import 'package:tour_me/pages/souvenir/Items/itemsAdd.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';

class ItemList extends StatefulWidget {
  final String shopId;

  const ItemList({Key? key, required this.shopId}) : super(key: key);

  @override
  State<ItemList> createState() => _ItemListState();
}

class _ItemListState extends State<ItemList> {
  late String shopId;
  late CollectionReference _souvenir;

  @override
  void initState() {
    super.initState();
    shopId = widget.shopId;
    print('shopId asdf $shopId');
    // Initialize _souvenir with the specific collection reference based on shopId
    _souvenir = FirebaseFirestore.instance.collection('Souvenir');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 10, top: 24, right: 10, bottom: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                PinkButton(
                  onPress: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                ItemAdd(shopId: widget.shopId)));
                  },
                  text: 'Add Product',
                  icon: const Icon(Icons.payment, color: Colors.white),
                ),
              ],
            ),
          ),
          Expanded(
              child: FutureBuilder<DocumentSnapshot>(
            future: _souvenir.doc(widget.shopId).get(),
            builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  Map<String, dynamic>? data =
                      snapshot.data!.data() as Map<String, dynamic>?;

                  if (data != null && data.containsKey('products')) {
                    final List<dynamic> productsList = data['products'];
                    print(productsList);
                    return buildProductCard(
                        productsList as Map<String, dynamic>?);
                  } else {
                    return const SizedBox.shrink(); // or some default UI
                  }
                } else {
                  return const Center(
                    child: Text('Document does not exist.'),
                  );
                }
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          )),
        ],
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomNav2(),
    );
  }

  Widget buildProductCard(Map<String, dynamic>? productsMap) {
    if (productsMap != null && productsMap.containsKey('products')) {
      dynamic productsData = productsMap['products'];

      if (productsData is List<dynamic>) {
        return ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: productsData.length,
          itemBuilder: (context, index) {
            final Map<String, dynamic> product = productsData[index];
            return buildProductTile(product, index);
          },
        );
      } else if (productsData is Map<String, dynamic>) {
        return ListView.builder(
          padding: const EdgeInsets.all(4),
          itemCount: productsData.length,
          itemBuilder: (context, index) {
            final String productId = productsData.keys.elementAt(index);
            final Map<String, dynamic> product = productsData[productId];
            return buildProductTile(product, productId);
          },
        );
      }
    }

    // Handle the case where productsMap is null or does not contain 'products' field
    return const SizedBox.shrink();
  }

  Widget buildProductTile(Map<String, dynamic> product, index) {
    print(index);
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ItemProfile(
                    productIndex: index.toString(), shopId: shopId)));
      },
      child: SizedBox(
        height: 80,
        child: Card(
          color: Colors.black,
          shape: RoundedRectangleBorder(
            side: const BorderSide(color: Colors.redAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          margin: const EdgeInsets.all(4),
          child: Row(
            children: [
              Text(
                '    ${product['productName']}',
                style: const TextStyle(color: Colors.white, fontSize: 25),
              ),
              const Spacer(),
              Text(
                'Rs. ${product['price']}    ',
                style: const TextStyle(color: Colors.greenAccent, fontSize: 25),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
