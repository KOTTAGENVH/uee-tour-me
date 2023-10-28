import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/pages/tourist_item_list.dart';
import 'package:tour_me/widgets/top_nav.dart';

class DisplayMapLocation extends StatefulWidget {
  final double zoom;
  final String text;
  final List<MapMarker> locations;
  final bool isBuildRoute;
  final bool showSouvenirs;
  final PageStep? step;

  const DisplayMapLocation({
    super.key,
    this.zoom = 10,
    this.text = "Location",
    required this.locations,
    this.isBuildRoute = false,
    this.showSouvenirs = false,
    required this.step,
  });

  @override
  State<DisplayMapLocation> createState() => _DisplayMapLocationState();
}

class _DisplayMapLocationState extends State<DisplayMapLocation> {
  final MapController _controller = MapController();
  late List<LatLng> _locationList;
  List<LatLng> _routeData = [];
  List<MapMarker> _souvenirList = [];
  List<MapMarker> _selectedSouList = [];

  @override
  void initState() {
    _locationList = widget.locations.map((marker) => marker.location).toList();
    if (widget.isBuildRoute) _getRoute();
    if (widget.showSouvenirs) _getSouvenirList();
    super.initState();
  }

  void _getSouvenirList() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference collection = firestore.collection('Souvenir');

    try {
      List<MapMarker> sovenirlocationList = [];
      QuerySnapshot querySnapshot = await collection.get();

      for (QueryDocumentSnapshot document in querySnapshot.docs) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;

        // Access specific properties from the document
        String? location = data['location'];
        String id = document.id;
        if (location == null) continue;

        // Split the string into latitude and longitude components
        List<String> latLngComponents = location.split(',');

        if (latLngComponents.length == 2) {
          // Convert the string components into double values
          double latitude = double.tryParse(latLngComponents[1]) ?? 0.0;
          double longitude = double.tryParse(latLngComponents[0]) ?? 0.0;

          // Create a LatLng object
          LatLng latLng = LatLng(latitude, longitude);

          sovenirlocationList.add(
            MapMarker(
              location: latLng,
              icon: const Icon(
                Icons.shopping_bag_sharp,
                color: Color(0xFF006803),
              ),
              onTap: () {
                _selectedSouList.add(_souvenirList.firstWhere((s) => latLng == s.location));

                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TouristItemList(
                        shopId: id,
                      ),
                    ));
              },
            ),
          );
        } else {
          print('Invalid latitude and longitude string format.');
        }
      }

      setState(() {
        _souvenirList = sovenirlocationList;
      });
    } catch (e) {
      print('Error reading data: $e');
    }
  }

  void _getRoute() async {
    try {
      List<ORSCoordinate> listOfCodes = _locationList.map((LatLng l) {
        return ORSCoordinate(latitude: l.latitude, longitude: l.longitude);
      }).toList();

      OpenRouteService client = OpenRouteService(apiKey: MyMap.routeAuthKey);
      List<ORSCoordinate> resp = await client.directionsMultiRouteCoordsPost(coordinates: listOfCodes);

      setState(() {
        _routeData = resp.map((ORSCoordinate c) => LatLng(c.latitude, c.longitude)).toList();
      });
    } catch (e, t) {
      print("Error: $e");
      print("StackTrace: $t");
    }
  }

  List<MapMarker> _getNeededLocations() {
    if (widget.step == PageStep.step1) {
      return widget.locations;
    } else if (widget.step == PageStep.step2) {
      return [...widget.locations, ..._selectedSouList];
    } else {
      return List.empty();
    }
  }

  void onNext() {
    Navigator.push(context, MaterialPageRoute(
      builder: (context) {
        return DisplayMapLocation(
          isBuildRoute: widget.step == PageStep.step2,
          locations: _getNeededLocations(),
          showSouvenirs: true,
          step: widget.step == PageStep.step1 ? PageStep.step2 : null,
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const TopNav(),
      floatingActionButton: FloatingActionButton(
          heroTag: 'fab',
          backgroundColor: const Color(0xFFFFDCE0),
          onPressed: onNext,
          child: const Icon(
            Icons.arrow_right_alt_outlined,
            size: 30,
            color: MyColors.pink,
          )),
      body: Stack(children: [
        FlutterMap(
          mapController: _controller,
          options: MapOptions(
            initialCameraFit: CameraFit.coordinates(
              coordinates: _locationList,
              padding: const EdgeInsets.all(100),
            ),
          ),
          children: [
            TileLayer(
              urlTemplate: MyMap.tileUrl,
              additionalOptions: MyMap.accessOptions,
            ),
            widget.isBuildRoute
                ? PolylineLayer(
                    polylines: [
                      Polyline(
                        strokeWidth: 3,
                        points: _routeData,
                        color: Colors.blue,
                      ),
                    ],
                  )
                : const SizedBox.shrink(),
            MarkerLayer(
              markers: [...widget.locations, ..._souvenirList].map((marker) {
                return Marker(
                  point: marker.location,
                  child: GestureDetector(
                    onTap: marker.onTap,
                    child: marker.icon,
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ]),
    );
  }
}

class MapMarker {
  final LatLng location;
  final Icon icon;
  final VoidCallback? onTap;

  MapMarker({
    required this.location,
    this.onTap,
    this.icon = const Icon(
      Icons.location_on_sharp,
      color: Colors.red,
    ),
  });
}

enum PageStep {
  step1,
  step2,
}
