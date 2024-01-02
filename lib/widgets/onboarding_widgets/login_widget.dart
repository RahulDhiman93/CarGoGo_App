import 'package:cargogomapp/utils/app_constants.dart';
import 'package:cargogomapp/widgets/helper_widgets/text_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(CountryCode countryCode, Function onCountryChange) {

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      textWidget(text: AppStrings.helloNiceToMeetYou),
      textWidget(
          text: AppStrings.getMovingWithCarGoGo,
          size: 20,
          fontWeight: FontWeight.bold),
      const SizedBox(
        height: 40,
      ),
      Container(
          width: double.infinity,
          height: 65,
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
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: InkWell(
                onTap: ()=> onCountryChange(),
                child: Row(
                  children: [
                    Expanded(child: SizedBox(
                      width: 15,
                      height: 15,
                      child: countryCode.flagImage(),
                    )),
                    const SizedBox(width: 5,),
                    textWidget(text: countryCode.dialCode),
                    const SizedBox(width: 5,),
                    const Icon(Icons.keyboard_arrow_down)
                  ],
                ),
              ),
            ),
            Container(
              width: 1,
              height: 55,
              color: Colors.black.withOpacity(0.2),
            ),
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(fontSize: 12.0, fontWeight: FontWeight.normal),
                    hintText: AppStrings.enterMobileNumber,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "${AppStrings.byCreating} \n",
                  style: GoogleFonts.poppins(color: Colors.black)),
              TextSpan(
                  text: AppStrings.termsOfService,
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              TextSpan(text: " and ", style: GoogleFonts.poppins(color: Colors.black)),
              TextSpan(
                  text: AppStrings.privacyPolicy,
                  style: GoogleFonts.poppins(
                      color: Colors.black, fontWeight: FontWeight.bold))
            ])),
      )
    ]),
  );
}
