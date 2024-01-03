import 'package:cargogomapp/views/onboarding/signup_screen.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cargogomapp/views/onboarding/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const CarGoGo());
}

class CarGoGo extends StatelessWidget {
  const CarGoGo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme),
      ),
      home: const SignupScreen(),
    );
  }
}