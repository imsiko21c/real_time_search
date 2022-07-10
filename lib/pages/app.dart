import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/news.dart';
import 'package:real_time_search/pages/home.dart';
import 'package:real_time_search/pages/settings.dart';

class App extends GetView<AppController> {
  const App({Key? key}) : super(key: key);

  BottomNavigationBarItem bottomNavigationBarItem({
    IconData? icon,
    IconData? activeIcon,
    String? label,
  }) {
    return BottomNavigationBarItem(
        icon: Icon(icon),
        activeIcon: Icon(
          activeIcon,
        ),
        label: label);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
          (() {
            switch (RouteName.values[controller.currentPage.value]) {
              case RouteName.realtime:
                return RealTime();
              case RouteName.news:
                return const News();
              case RouteName.settings:
                return const Settings();
            }
          }),
        ),
        bottomNavigationBar: Obx(
          () => BottomNavigationBar(
              currentIndex: controller.currentPage.value,
              selectedItemColor: Colors.black,
              unselectedItemColor: Colors.black.withOpacity(0.3),
              selectedLabelStyle: const TextStyle(fontFamily: 'ibm'),
              unselectedLabelStyle: const TextStyle(fontFamily: 'ibm'),
              onTap: (index) {
                controller.changePage(index);
              },
              items: [
                bottomNavigationBarItem(
                  icon: Icons.search_outlined,
                  activeIcon: Icons.search,
                  label: '실시간 검색어',
                ),
                bottomNavigationBarItem(
                  icon: Icons.newspaper_outlined,
                  activeIcon: Icons.newspaper,
                  label: '주요 뉴스',
                ),
                bottomNavigationBarItem(
                  icon: Icons.settings_outlined,
                  activeIcon: Icons.settings,
                  label: '세팅',
                ),
              ]),
        ));
  }
}
