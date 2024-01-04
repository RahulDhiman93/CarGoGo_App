import 'dart:async';
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
  TextEditingController fromAddress = TextEditingController();
  TextEditingController toAddress = TextEditingController();

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
                    textEditingController: fromAddress,
                    googleAPIKey: "AIzaSyDBEaQQak_ENQqohJtIecNuftTM1ARfh_0",
                    debounceTime: 400,
                    isLatLngRequired: true,
                    itmClick: (prediction) {
                      fromAddress.text = prediction.description!;
                      fromAddress.selection = TextSelection.fromPosition(
                          TextPosition(offset: prediction.description!.length));
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
                  textEditingController: toAddress,
                  googleAPIKey: "AIzaSyDBEaQQak_ENQqohJtIecNuftTM1ARfh_0",
                  debounceTime: 400,
                  isLatLngRequired: true,
                  itmClick: (prediction) {
                    toAddress.text = prediction.description!;
                    toAddress.selection = TextSelection.fromPosition(
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
}
