import 'dart:async';
import 'dart:convert';
import 'package:cargogomapp/utils/app_colors.dart';
import 'package:cargogomapp/utils/app_constants.dart';
import 'package:cargogomapp/widgets/helper_widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_places_autocomplete_text_field/google_places_autocomplete_text_field.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../models/user_core_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Completer<GoogleMapController> _mapController =
      Completer<GoogleMapController>();
  String? _mapStyle;
  String googleAPiKey = "AIzaSyDBEaQQak_ENQqohJtIecNuftTM1ARfh_0";

  TextEditingController sourceAddress = TextEditingController();
  TextEditingController destinationAddress = TextEditingController();

  LatLng? sourcePosition;
  LatLng? destinationPosition;

  Set<Marker> markers = <Marker>{};
  Set<Polyline> polylines = <Polyline>{};
  List<LatLng> polylineCoordinates = [];
  PolylinePoints polylinePoints = PolylinePoints();


  static const CameraPosition _kCarGoGoHQ = CameraPosition(
    target: LatLng(37.34896133580664, -121.936849655962),
    zoom: 14.4746,
  );


  @override
  void initState() {
    super.initState();
    rootBundle.loadString('assets/map_style.txt').then((string) {
      _mapStyle = string;
    });
  }

  Future<UserCoreData> getUser() async {
    UserCoreData? savedUser = await UserCoreData.getUser();
    return savedUser!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        GoogleMap(
          mapType: MapType.normal,
          markers: markers,
          polylines: polylines,
          initialCameraPosition: _kCarGoGoHQ,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          zoomControlsEnabled: false,
          onMapCreated: (GoogleMapController controller) {
            controller.setMapStyle(_mapStyle);
            _mapController.complete(controller);
          },
        ),
        FutureBuilder<UserCoreData>(
          future: getUser(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              return profileTile(snapshot.data!);
            }
          },
        ),
        addressField(),
        currentLocationIcon()
      ]),
    );
  }

  Widget profileTile(UserCoreData user) {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          width: double.infinity,
          height: 65,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: AppColors.purpleColor.withOpacity(0.1),
                  spreadRadius: 3,
                  blurRadius: 2,
                )
              ]),
          child: SizedBox(
            width: Get.width,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: AppColors.purpleColor,
                  child: textWidget(
                      text: user.firstName[0], size: 20, color: Colors.white),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          const TextSpan(
                              text: "${AppStrings.goodMorning}, ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                          TextSpan(
                              text: user.firstName,
                              style: const TextStyle(
                                color: AppColors.purpleColor,
                                fontSize: 14,
                              )),
                        ],
                      ),
                    ),
                    textWidget(
                        text: AppStrings.whereAreYouGoing,
                        size: 20,
                        fontWeight: FontWeight.bold)
                  ],
                )
              ],
            ),
          )),
    );
  }

  Widget addressField() {
    return Positioned(
        top: 130,
        left: 25,
        right: 25,
        child: Column(
          children: [
            Container(
                width: double.infinity,
                height: 45,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        spreadRadius: 3,
                        blurRadius: 2,
                      )
                    ]),
                child: GooglePlacesAutoCompleteTextFormField(
                  inputDecoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                      hintText: AppStrings.from,
                      border: InputBorder.none,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.location_pin,
                          color: AppColors.purpleColor,
                        ),
                      )),
                    textEditingController: sourceAddress,
                    googleAPIKey: googleAPiKey,
                    debounceTime: 800,
                    isLatLngRequired: true,
                    getPlaceDetailWithLatLng: (prediction) {
                      sourcePosition = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
                      destinationAddress.text = "";
                      destinationPosition = null;
                      _showMarkersAndPolyline();
                    },
                    itmClick: (prediction) {
                      sourceAddress.text = prediction.description!;
                      sourceAddress.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length),
                      );
                      FocusScope.of(context).unfocus();
                    })
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 3,
                      blurRadius: 2,
                    )
                  ]),
              child: GooglePlacesAutoCompleteTextFormField(
                  inputDecoration: InputDecoration(
                      hintStyle: GoogleFonts.poppins(
                          fontSize: 15.0, fontWeight: FontWeight.bold),
                      hintText: AppStrings.to,
                      border: InputBorder.none,
                      suffixIcon: const Padding(
                        padding: EdgeInsets.only(left: 10),
                        child: Icon(
                          Icons.pin_end,
                          color: AppColors.purpleColor,
                        ),
                      )),
                  textEditingController: destinationAddress,
                  googleAPIKey: googleAPiKey,
                  debounceTime: 400,
                  isLatLngRequired: true,
                  getPlaceDetailWithLatLng: (prediction) {
                    destinationPosition = LatLng(double.parse(prediction.lat!), double.parse(prediction.lng!));
                    _showMarkersAndPolyline();
                  },
                  itmClick: (prediction) {
                    destinationAddress.text = prediction.description!;
                    destinationAddress.selection = TextSelection.fromPosition(
                        TextPosition(offset: prediction.description!.length));
                    FocusScope.of(context).unfocus();
                  }),
            ),
          ],
        ));
  }

  Widget currentLocationIcon() {
    return const Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: CircleAvatar(
          radius: 25,
          child: Icon(
            Icons.my_location_rounded,
            color: AppColors.purpleColor,
          ),
        ),
      ),
    );
  }

  Future<void> _showMarkersAndPolyline() async {
    if (sourcePosition != null && destinationPosition != null) {
      final sourcePosition = this.sourcePosition;
      final destinationPosition = this.destinationPosition;
      await Future.delayed(const Duration(seconds: 1));
      markers.clear();
      polylines.clear();
      polylineCoordinates.clear();
      markers.add(Marker(
        markerId: MarkerId(sourceAddress.text),
        infoWindow: InfoWindow(title: "Source: ${sourceAddress.text}"),
        position: sourcePosition!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));
      markers.add(Marker(
        markerId: MarkerId(destinationAddress.text),
        infoWindow: InfoWindow(title: "Destination: ${destinationAddress.text}"),
        position: destinationPosition!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange),
      ));
      _getPolyline();
      await Future.delayed(const Duration(seconds: 1));
      _calculateBounds(polylineCoordinates);
      setState(() {});
    } else if (sourcePosition != null) {
      final sourcePosition = this.sourcePosition;
      await Future.delayed(const Duration(seconds: 1));
      markers.clear();
      polylines.clear();
      polylineCoordinates.clear();
      markers.add(Marker(
        markerId: MarkerId(sourceAddress.text),
        infoWindow: InfoWindow(title: "Source: ${sourceAddress.text}"),
        position: sourcePosition!,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
      ));
      CameraPosition kPoint = CameraPosition(
          target: sourcePosition,
          zoom: 13);
      final GoogleMapController controller = await _mapController.future;
      await controller.animateCamera(CameraUpdate.newCameraPosition(kPoint));
      setState(() {});
    }
  }

  _getPolyline() async {
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleAPiKey,
       PointLatLng(sourcePosition!.latitude, sourcePosition!.longitude),
        PointLatLng(destinationPosition!.latitude, destinationPosition!.longitude),
        travelMode: TravelMode.driving,
        );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    }
    _addPolyLine();
  }

  _addPolyLine() {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      visible: true,
      width: 2,
      color: AppColors.purpleColor.withOpacity(0.5),
      points: polylineCoordinates,
    );
    polylines.add(polyline);
    setState(() {});
  }

  _calculateBounds(List<LatLng> points) async {
    double minLat = points[0].latitude;
    double maxLat = points[0].latitude;
    double minLng = points[0].longitude;
    double maxLng = points[0].longitude;

    for (LatLng point in points) {
      if (point.latitude < minLat) minLat = point.latitude;
      if (point.latitude > maxLat) maxLat = point.latitude;
      if (point.longitude < minLng) minLng = point.longitude;
      if (point.longitude > maxLng) maxLng = point.longitude;
    }

    LatLngBounds bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );

    final GoogleMapController controller = await _mapController.future;
    await controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 10));
    setState(() {});
  }

}
