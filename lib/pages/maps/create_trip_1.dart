import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';

class CreateTrip1 extends StatefulWidget {
  static const String routeName = '/createTrip1';
  const CreateTrip1({super.key});

  @override
  State<CreateTrip1> createState() => _CreateTrip1State();
}

class _CreateTrip1State extends State<CreateTrip1> {
  final TextEditingController _tripName = TextEditingController();
  MapController mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: const Text('Create Trip'),
        ),
        body: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                initialCenter: MyMap.initialCenter,
                initialZoom: MyMap.initialZoom,
              ),
              children: [
                TileLayer(
                  urlTemplate: MyMap.tileUrl,
                  additionalOptions: MyMap.accessOptions,
                ),
                const MarkerLayer(
                  markers: [
                    Marker(
                      point: LatLng(7.213658, 79.839591),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                    ),
                    Marker(
                      point: LatLng(7.267890, 79.861132),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                    ),
                    Marker(
                      point: LatLng(7.175357, 79.877912),
                      child: Icon(
                        Icons.location_on_sharp,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Positioned(
              top: 15,
              left: 15,
              right: 15,
              child: TextField(
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: 'Set Route Name',
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.5),
                  focusedBorder: const OutlineInputBorder(),
                  alignLabelWithHint: true, // This is the key property
                ),
                controller: _tripName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
