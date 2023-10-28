import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:open_route_service/open_route_service.dart';
import 'package:tour_me/constants.dart';

class DisplayMapLocation extends StatefulWidget {
  final double zoom;
  final String text;
  final List<MapMarker> locations;
  final bool isBuildRoute;

  const DisplayMapLocation({
    super.key,
    this.zoom = 10,
    this.text = "Location",
    required this.locations,
    this.isBuildRoute = false,
  });

  @override
  State<DisplayMapLocation> createState() => _DisplayMapLocationState();
}

class _DisplayMapLocationState extends State<DisplayMapLocation> {
  final MapController _controller = MapController();
  late List<LatLng> _locationList;
  List<LatLng> _routeData = [];

  @override
  void initState() {
    _locationList = widget.locations.map((marker) => marker.location).toList();
    if (widget.isBuildRoute) _getRoute();
    super.initState();
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
              markers: widget.locations.map((marker) {
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
