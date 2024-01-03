import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/views/home/home_screen.dart';
import 'package:cargogomapp/views/onboarding/login_screen.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    accessTokenCall();
  }

  accessTokenCall() async {
    await Future.delayed(const Duration(seconds: 3));
    bool isAccessTokenValid = await UserApi.accessTokenCall();
    setState(() {
      isLoading = false;
    });

    if (isAccessTokenValid) {
      Get.off(const HomeScreen());
    } else {
      Get.off(const LoginScreen());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: Get.width,
        height: Get.height,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              onBoardingLogoWidget(0.7),
              const SizedBox(height: 60,),
              if (isLoading)
                const CircularProgressIndicator()
            ],
          ),
        ),
      ),
    );
  }
}