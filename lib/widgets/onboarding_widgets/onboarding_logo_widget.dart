import 'package:cargogomapp/widgets/helper_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Widget onBoardingLogoWidget() {
  return Container(
    width: Get.width,
    height: Get.height * 0.4,
    decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/mask.png'), fit: BoxFit.fill)),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/logo.png',
          width: 100,
          height: 100,
        ),
        const SizedBox(height: 05),
        textWidget(text: "CarGoGo", size: 32, color: Colors.white)
      ],
    ),
  );
}
