import 'package:cargogomapp/utils/user_api.dart';
import 'package:cargogomapp/widgets/onboarding_widgets/onboarding_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

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
              onBoardingLogoWidget(0.8),
              const SizedBox(height: 40,),
            ],
          ),
        ),
      ),
    );
  }
}