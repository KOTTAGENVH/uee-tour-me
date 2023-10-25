import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';
import 'package:tour_me/widgets/message_popup.dart';

class GetMapLocation extends StatefulWidget {
  static const String routeName = '/getMapLocation';
  const GetMapLocation({super.key});

  static Future<LatLng?> getLocation(BuildContext context) async {
    LatLng? location = await Navigator.pushNamed(
      context,
      GetMapLocation.routeName,
    ) as LatLng?;

    return location;
  }

  @override
  State<GetMapLocation> createState() => _GetMapLocationState();
}

class _GetMapLocationState extends State<GetMapLocation> {
  final mapController = MapController();
  late LatLng location;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'ok',
        backgroundColor: MyColors.pink,
        onPressed: () {
          location = mapController.camera.center;
          MessagePopUp.display(
            context,
            icon: const Icon(
              Icons.my_location_outlined,
              color: MyColors.pink,
            ),
            title: 'Select Location?',
            message: "lng: ${location.longitude.toStringAsFixed(4)}, lat: ${location.latitude.toStringAsFixed(4)}",
            showCancel: true,
            onDismiss: () {
              Navigator.pop(context, location);
            },
          );
        },
        child: const Icon(Icons.check),
      ),
      body: Stack(
        children: [
          FlutterMap(
            mapController: mapController,
            options: MapOptions(
              initialCenter: MyMap.initialCenter,
              initialZoom: MyMap.initialZoom,
              onMapReady: () {
                mapController.mapEventStream.listen((evt) {});
              },
            ),
            children: [
              TileLayer(
                urlTemplate: MyMap.tileUrl,
                additionalOptions: MyMap.accessOptions,
              ),
            ],
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 15,
            left: MediaQuery.of(context).size.width / 2 - 15,
            child: const Icon(
              Icons.location_searching_sharp,
              color: MyColors.pink,
              size: 30,
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height / 2 - 2.5,
            left: MediaQuery.of(context).size.width / 2 - 2.5,
            child: const Icon(
              Icons.circle,
              color: MyColors.pink,
              size: 5,
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: FloatingActionButton(
              heroTag: 'back',
              backgroundColor: Colors.black,
              onPressed: () => Navigator.pop(context),
              child: const Icon(Icons.close_sharp),
            ),
          )
        ],
      ),
    );
  }
}
