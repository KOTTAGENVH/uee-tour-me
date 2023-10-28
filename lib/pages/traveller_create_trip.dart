import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/models/location_item.dart';
import 'package:tour_me/pages/maps/display_map_location.dart';
import 'package:tour_me/pages/tourist/destination_detail_page.dart';
import 'package:tour_me/widgets/bottom_nav.dart';
import 'package:tour_me/widgets/top_nav.dart';

class TravelerCreateTrip extends StatefulWidget {
  static const String routeName = '/travelrCreatetrip';
  const TravelerCreateTrip({super.key});

  @override
  State<TravelerCreateTrip> createState() => _TravelerCreateTripState();
}

class _TravelerCreateTripState extends State<TravelerCreateTrip> {
  late List<LocationItem> locationsList = [];
  List<LocationItem> selectedLocationList = [];

  Future<void> _postInit() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('Destination');

    try {
      List<LocationItem> locationItemList = [];
      QuerySnapshot querySnapshot = await collection.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Access specific properties from the document
        String? location = data['location'];
        String? image = data['destinationImage1'];
        String? name = data['destinationName'];

        locationItemList.add(LocationItem(
          id: document.id,
          name: name,
          location: location,
          imageUrl: image,
        ));
      }

      setState(() {
        locationsList = locationItemList;
      });
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  @override
  void initState() {
    _postInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    void onNext() {
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          List<String?> stringListOfLocations = selectedLocationList.map((l) => l.location).toList();
          List<String?> listOfDestinationIds = selectedLocationList.map((l) => l.id).toList();
          List<MapMarker> listofMapMarkers = [];

          for (String? latLngString in stringListOfLocations) {
            List<String>? components = latLngString?.split(',');
            if (components?.length == 2) {
              double? lat = double.tryParse(components![1]);
              double? lng = double.tryParse(components[0]);

              if (lat != null && lng != null) {
                listofMapMarkers.add(MapMarker(
                  location: LatLng(lat, lng),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DestinationDetailPage(
                            destinationId: listOfDestinationIds[stringListOfLocations.indexOf(latLngString)]!,
                          ),
                        ));
                  },
                ));
              }
            }
          }

          return DisplayMapLocation(
            locations: listofMapMarkers,
            step: PageStep.step1,
          );
        },
      ));
    }

    void onItemSelect(LocationItem location) {
      setState(() {
        if (!selectedLocationList.contains(location)) {
          selectedLocationList.add(location);
        } else {
          selectedLocationList.remove(location);
        }
      });
    }

    return Scaffold(
      appBar: const TopNav(),
      bottomNavigationBar: const BottomNav(selcted: Selections.add),
      floatingActionButton: FloatingActionButton(
        heroTag: 'fab',
        backgroundColor: const Color(0xFFFFDCE0),
        onPressed: onNext,
        child: Text(
          selectedLocationList.length.toString(),
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: MyColors.pink,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(gradient: MyColors.backgrounGradient),
        child: ListView.builder(
          itemCount: locationsList.length,
          itemBuilder: (context, index) {
            LocationItem location = locationsList[index];
            return LocationListItemCard(
              item: location,
              isSelected: selectedLocationList.contains(location),
              onTap: () => onItemSelect(location),
            );
          },
        ),
      ),
    );
  }
}

class LocationListItemCard extends StatelessWidget {
  final LocationItem item;
  final VoidCallback onTap;
  final bool isSelected;
  const LocationListItemCard({
    super.key,
    required this.item,
    required this.onTap,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(
              color: MyColors.pink,
              width: 2,
            ),
          ),
          elevation: 2,
          color: isSelected ? MyColors.pink.withOpacity(0.8) : MyColors.black2,
          child: SizedBox(
            height: 150,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  flex: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20),
                    ),
                    child: Image.network(
                      item.imageUrl ?? MyImages.noLocationImage,
                      width: double.infinity, // Make the image take the full width of the container
                      height: double.infinity, // Make the image take the full height of the container
                      fit: BoxFit.cover, // Adjust the fit as needed (e.g., BoxFit.contain, BoxFit.fill)
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.name ?? '',
                          style: const TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
