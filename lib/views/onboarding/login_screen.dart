import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/views/onboarding/signup_screen.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/login_widget.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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
              onBoardingLogoWidget(0.4),
              const SizedBox(height: 40,),
              loginWidget((String email, String password){
                UserApi.login(email, password);
              }, (){
                Get.off(const SignupScreen());
              }),
            ],
          ),
        ),
      ),
    );
  }
}