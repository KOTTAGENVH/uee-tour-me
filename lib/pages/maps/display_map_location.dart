import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:tour_me/constants.dart';

class DisplayMapLocation extends StatefulWidget {
  final double zoom;
  final String text;
  final List<MapMarker> locations;

  const DisplayMapLocation({
    super.key,
    this.zoom = 10,
    this.text = "Location",
    required this.locations,
  });

  @override
  State<DisplayMapLocation> createState() => _DisplayMapLocationState();
}

class _DisplayMapLocationState extends State<DisplayMapLocation> {
  final MapController _controller = MapController();
  late List<LatLng> _locationList;

  @override
  void initState() {
    _locationList = widget.locations.map((marker) => marker.location).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.text),
      ),
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
            MarkerLayer(
              markers: widget.locations.map((marker) {
                return Marker(
                  point: marker.location,
                  child: marker.icon,
                );
              }).toList(),
            )
          ],
        ),
      ]),
    );
  }
}

class MapMarker {
  final LatLng location;
  final Icon icon;

  MapMarker({
    required this.location,
    this.icon = const Icon(
      Icons.location_on_sharp,
      color: Colors.red,
      size: 25,
    ),
  });
}
