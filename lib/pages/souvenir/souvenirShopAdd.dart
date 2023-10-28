// ignore_for_file: use_build_context_synchronously
import 'package:latlong2/latlong.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:secure_shared_preferences/secure_shared_preferences.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/maps/get_map_location.dart';
import 'package:tour_me/pages/souvenir/homePage.dart';
import 'package:tour_me/widgets/bottom_nav2.dart';
import 'package:tour_me/widgets/pink_button.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tour_me/widgets/upload_image_button2.dart';
import 'package:tour_me/widgets/upload_single_images.dart';

class SouvenirAddPage extends StatefulWidget {
  const SouvenirAddPage({super.key});

  @override
  State<SouvenirAddPage> createState() => _SouvenirAddPageState();
}

class _SouvenirAddPageState extends State<SouvenirAddPage> {
  String retirevedlocation = '';
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationImage1 = TextEditingController();

  final bool isActive = false;
  late SecureSharedPref pref;
  late String? uId = '';
  @override
  void initState() {
    super.initState();
    _initUser();
  }

  Future<void> _initUser() async {
    pref = await SecureSharedPref.getInstance();
    uId = await pref.getString(MyPrefTags.userId, isEncrypted: true);
    print('uid $uId');
  }

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

  final CollectionReference _souvenir =
      FirebaseFirestore.instance.collection('Souvenir');

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
                          if (imageUrl != null && imageUrl.isNotEmpty) {
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
                          if (imageUrl!.isNotEmpty) {
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
                      PinkButton(
                        onPress: () async {
                          LatLng? location =
                              await GetMapLocation.getLocation(context);

                          if (location != null) {
                            retirevedlocation =
                                "${location.longitude},${location.latitude}";
                            print('location: $retirevedlocation');
                          }
                        },
                        text: 'Add Location',
                        icon:
                            const Icon(Icons.location_on, color: Colors.white),
                      ),
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
                      final String address = _addressController.text;
                      final String description = _descriptionController.text;
                      if (name.isNotEmpty &&
                          address.isNotEmpty &&
                          description.isNotEmpty) {
                        print('Image URL: ${_locationImage1.text}');
                        await _souvenir.add({
                          "userId": uId,
                          "shopName": name,
                          "address": address,
                          "description": description,
                          "isActive": isActive,
                          "lastMonthlyPayDate":
                              DateTime.now().subtract(const Duration(days: 40)),
                          "location": retirevedlocation,
                          "image": _locationImage1.text
                        });

                        _nameController.text = '';
                        _addressController.text = '';
                        _descriptionController.text = '';
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Shop added successfully!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SouvenirHomePage()),
                        );
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
