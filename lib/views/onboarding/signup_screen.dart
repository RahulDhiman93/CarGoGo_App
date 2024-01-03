import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/signup_widget.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              onBoardingLogoWidget(0.3),
              const SizedBox(height: 40,),
              signupWidget((String firstName, String lastName, String email, String password){
                UserApi.register(firstName, lastName, email, password);
              }),
            ],
          ),
        ),
      ),
    );
  }
}