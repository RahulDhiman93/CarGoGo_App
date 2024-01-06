import 'package:cargogomapp/utils/app_colors.dart';
import 'package:cargogomapp/widgets/helper_widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../views/home/home_screen.dart';
import '../onboarding_widgets/onboarding_logo_widget.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        physics: const NeverScrollableScrollPhysics(),
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 350,
            color: AppColors.purpleColor,
            alignment: Alignment.center,
            child: onBoardingLogoWidget(1),
          ),
          const SizedBox(height: 20,),
          ListTile(
            leading: const Icon(Icons.home),
            title: textWidget(text: "Home", fontWeight: FontWeight.bold, size: 16),
            onTap: () => {
              Get.off(const HomeScreen()),
              Navigator.of(context).pop()
            },
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle_rounded),
            title: textWidget(text: "Profile", fontWeight: FontWeight.bold, size: 16),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: textWidget(text: "Settings", fontWeight: FontWeight.bold, size: 16),
            onTap: () => {Navigator.of(context).pop()},
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: textWidget(text: "Logout", fontWeight: FontWeight.bold, size: 16),
            onTap: () => {Navigator.of(context).pop()},
          ),
        ],
      ),
    );
  }
}