import 'package:cargogomapp/widgets/onboarding_widgets/login_widget.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:fl_country_code_picker/fl_country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  /// Default.
  final countryPicker = const  FlCountryCodePicker();
  CountryCode countryCode = const CountryCode(name: 'USA', code: 'US', dialCode: '+1');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onBoardingLogoWidget(),
              const SizedBox(height: 40,),
              loginWidget(countryCode, () async {
                final code= await countryPicker.showPicker(context: context);
                if (code!= null) countryCode = code;
                setState(() {

                });
              }),
            ],
          ),
        ),
      ),
    );
  }
}