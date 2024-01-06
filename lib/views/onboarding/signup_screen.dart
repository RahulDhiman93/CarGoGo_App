import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/views/onboarding/login_screen.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/signup_widget.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/helper_widgets/error_widget.dart';
import '../home/home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    isLoading = false;
  }

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
              signupWidget((String firstName, String lastName, String email, String password) async {
                if (firstName.isEmpty || lastName.isEmpty || email.isEmpty || password.isEmpty) {
                  errorWidget(context: context, message: "Please enter all the details");
                  return;
                }
                setState(() {
                  isLoading = true;
                });
                bool ok = await UserApi.register(firstName, lastName, email, password);
                if (!mounted) return;
                setState(() {
                  isLoading = false;
                });
                if (ok) {
                  Get.off(const HomeScreen());
                } else {
                  errorWidget(context: context, message: "Something went wrong");
                }
              }, () {
                Get.off(const LoginScreen());
              }),
              if (isLoading)
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                ),
            ],
          ),
        ),
      ),
    );
  }
}