import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/maps/get_map_location.dart';
import 'package:tour_me/pages/souvenir/Items/itemList.dart';
import 'package:tour_me/pages/souvenir/Items/itemsAdd.dart';
import 'package:tour_me/pages/souvenir/souvenirShopAdd.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:latlong2/latlong.dart';

class ShopProfile extends StatefulWidget {
  final String shopId;

  const ShopProfile({super.key, required this.shopId});

  @override
  State<ShopProfile> createState() => _ShopProfileState();
}

String retirevedlocation = '';
final TextEditingController _nameController = TextEditingController();
final TextEditingController _addressController = TextEditingController();
final TextEditingController _descriptionController = TextEditingController();

final CollectionReference _souvenir =
    FirebaseFirestore.instance.collection('Souvenir');

class _ShopProfileState extends State<ShopProfile> {
  String shopName = '';
  String shopDescription = '';
  String shopAddress = '';
  String existingLocation = '';
  bool isSaveEnabled = false;
  String shopImageUrl = '';
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
          existingLocation = shopSnapshot['location'];
          shopImageUrl = shopSnapshot['image'];

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
      if (_nameController.text.isEmpty ||
          _addressController.text.isEmpty ||
          _descriptionController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please fill in all fields.'),
            backgroundColor: Colors.red,
          ),
        );
        return;
      }
      await _souvenir.doc(widget.shopId).update({
        'shopName': _nameController.text,
        'description': _descriptionController.text,
        'address': _addressController.text,
        "location": retirevedlocation
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

  void saveLocation() async {
    try {
      // Check if the retrieved location is not empty
      if (retirevedlocation.isNotEmpty) {
        // Update the location in Firestore
        await _souvenir.doc(widget.shopId).update({
          'location': retirevedlocation,
        });

        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Location saved successfully!'),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select a location on the map.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle errors during location saving
      print('Error saving location: $e');
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
            const SizedBox(height: 10),
            if (shopImageUrl.isNotEmpty)
              ClipRRect(
                borderRadius: BorderRadius.circular(15.0),
                child: Image.network(
                  shopImageUrl,
                  width: 100, // Set the width of the image
                  height: 100, // Set the height of the image
                  fit: BoxFit.cover, // Adjust this based on your requirements
                ),
              ),
            const SizedBox(height: 20),
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
                          onPress: () async {
                            LatLng? location =
                                await GetMapLocation.getLocation(context);

                            if (location != null) {
                              retirevedlocation =
                                  "${location.longitude},${location.latitude}";
                              print('location: $retirevedlocation');
                              // Call the saveLocation method when the user updates the location
                              saveLocation();
                            }
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
                  const SizedBox(height: 10),
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ItemList(shopId: widget.shopId),
                            ),
                          );
                        },
                        text: 'Product List',
                        icon: const Icon(Icons.list, color: Colors.white),
                      ),
                      const SizedBox(width: 10),
                      PinkButton(
                        onPress: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      ItemAdd(shopId: widget.shopId)));
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
