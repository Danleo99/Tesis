import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:telerobot/helpers/theme_controller.dart';
import 'package:telerobot/widgets/robot_card.dart';

import '../../../helpers/dash_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);
  final themeController = Get.put(ThemeController());
  final DashboardContoller ctrl = Get.find();

  @override
  Widget build(BuildContext context) {
    List _cards = [
      RobotCard(
        robotImage: 'images/scara.png',
        controller: ctrl.cardControllers[0],
      )
    ];
    return SafeArea(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Image.asset(
                  'images/telerobotSmWhite.png',
                  height: 75,
                ),
              ),
              const Expanded(
                flex: 2,
                child: Text(
                  'Robots',
                  style: TextStyle(
                    fontSize: 60,
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: IconButton(
                  icon: const Icon(CupertinoIcons.heart),
                  onPressed: () {
                    if (Get.isDarkMode) {
                      themeController.changeThemeMode(ThemeMode.light);
                      themeController.saveTheme(false);
                    } else {
                      themeController.changeThemeMode(ThemeMode.dark);
                      themeController.saveTheme(true);
                    }
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: CarouselSlider.builder(
              itemCount: _cards.length,
              itemBuilder:
                  (BuildContext context, int itemIndex, int pageViewIndex) =>
                      Hero(tag: itemIndex, child: _cards[itemIndex]),
              options: CarouselOptions(
                  height: MediaQuery.of(context).size.height / 1.5),
            ),
          )
        ],
      ),
    );
  }
}
