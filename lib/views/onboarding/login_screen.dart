import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/views/home/home_screen.dart';
import 'package:cargogomapp/views/onboarding/signup_screen.dart';
import 'package:cargogomapp/widgets/helper_widgets/error_widget.dart';
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
              loginWidget((String email, String password) async {
                if (email.isEmpty || password.isEmpty) {
                  errorWidget(context: context, message: "Please enter all the details");
                  return;
                }
                bool ok = await UserApi.login(email, password);
                if (!mounted) return;
                if (ok) {
                  Get.off(const HomeScreen());
                } else {
                  errorWidget(context: context, message: "Something went wrong");
                }
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