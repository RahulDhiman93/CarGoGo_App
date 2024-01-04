import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  String? _mapStyle;

  static const CameraPosition _kCarGoGoHQ = CameraPosition(
    target: LatLng(37.34896133580664, -121.936849655962),
    zoom: 14.4746,
  );

  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string){
      _mapStyle = string;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _kCarGoGoHQ,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              controller.setMapStyle(_mapStyle);
              _mapController.complete(controller);
            },
          ),
        ]
      ),
    );
  }
}
