import 'package:cargogomapp/utils/app_colors.dart';
import 'package:cargogomapp/utils/app_constants.dart';
import 'package:cargogomapp/widgets/helper_widgets/text_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget loginWidget(Function(String email, String password) onLoginTap) {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      textWidget(text: AppStrings.getMovingWithCarGoGo),
      textWidget(
          text: AppStrings.login,
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
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(fontSize: 12.0, fontWeight: FontWeight.normal),
                    hintText: AppStrings.enterEmail,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
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
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    hintStyle: GoogleFonts.poppins(fontSize: 12.0, fontWeight: FontWeight.normal),
                    hintText: AppStrings.enterPassword,
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 20,
      ),
      Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ElevatedButton(
          onPressed: ()=> onLoginTap(
            emailController.text,
            passwordController.text,
          ),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, primary: AppColors.purpleColor,
          ),
          child: const Text(
            'Login',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      const SizedBox(
        height: 40,
      ),
      Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: RichText(
            textAlign: TextAlign.center,
            text: TextSpan(children: [
              TextSpan(
                  text: "${AppStrings.byLogin} \n",
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
