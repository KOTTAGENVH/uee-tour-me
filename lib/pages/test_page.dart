import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/maps/display_map_location.dart';
import 'package:tour_me/pages/maps/get_map_location.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/pink_button.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  static const String routeName = '/testPage';

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
            )
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
                  PinkButton(
                    onPress: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DisplayMapLocation(
                            locations: [
                              MapMarker(
                                location: MyMap.initialCenter,
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.green,
                                ),
                              ),
                              MapMarker(
                                location: const LatLng(7.4777, 80.4050),
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.red,
                                ),
                              ),
                              MapMarker(
                                location: const LatLng(9.66115090, 80.02510188),
                                icon: const Icon(
                                  Icons.star,
                                  color: Colors.black,
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                    text: 'View Location',
                  ),
                  PinkButton(
                    onPress: () async {
                      LatLng? location = await GetMapLocation.getLocation(context);
                      if (location != null) print("Longitude: ${location.longitude}, Latitude: ${location.latitude}");
                    },
                    text: 'get Location',
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Shop name',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.shop_2,
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
                          onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                          text: 'Add Image',
                          icon: const Icon(Icons.add_a_photo, color: Colors.white)),
                      const SizedBox(width: 10),
                      PinkButton(
                          onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                          text: 'Add Location',
                          icon: const Icon(Icons.location_on, color: Colors.white)),
                    ], // Add some spacing
                  ),
                  const SizedBox(height: 20), // Add some spacing
                  TextFormField(
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
                  const SizedBox(height: 20), // Add some spacing
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Description',
                      labelStyle: const TextStyle(color: Colors.white),
                      prefixIcon: const Icon(
                        Icons.description,
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
                      onPress: () => Navigator.pushReplacementNamed(context, Test.routeName),
                      text: 'Add Image',
                      icon: const Icon(Icons.add, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const BottomNav(),
    );
  }
}
