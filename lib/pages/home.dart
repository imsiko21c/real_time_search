// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/ranking_data/nate.dart';
import 'package:real_time_search/pages/ranking_data/result%20copy.dart';
import 'package:real_time_search/pages/ranking_data/signal.dart';
import 'package:real_time_search/pages/ranking_data/zoom.dart';
import 'package:intl/intl.dart';

class RealTime extends StatefulWidget {
  RealTime({Key? key}) : super(key: key);

  @override
  State<RealTime> createState() => _RealTimeState();
}

class _RealTimeState extends State<RealTime>
    with SingleTickerProviderStateMixin {
  final pageController = PageController(initialPage: 0);
  AppController controller = Get.find<AppController>();
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(
      length: 4,
      vsync: this,
    );
    super.initState();
  }

  Widget tabUI(String logoName, [double size = 90]) {
    return Container(
      height: 40,
      alignment: Alignment.center,
      child: Image.asset('assets/images/$logoName.png', width: size),
    );
  }

  Widget tabBar() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          width: 0.25,
          color: Colors.black.withOpacity(0.3),
        ),
      ),
      child: TabBar(
        tabs: [
          tabUI('now_off', 50),
          tabUI('signal_ci_off'),
          tabUI('nate_off'),
          tabUI('zoom_off', 50),
        ],
        controller: _tabController,
        indicatorWeight: 3.0,
        indicatorSize: TabBarIndicatorSize.tab,
        indicatorPadding: const EdgeInsets.symmetric(horizontal: 12.0),
        indicatorColor: indicatorColors(),
        onTap: (index) {
          controller.changeTab(index);
        },
      ),
    );
  }

  Color indicatorColors() {
    switch (controller.currentTab.value) {
      case 0:
        return Colors.purple;

      case 1:
        return Colors.green;

      case 2:
        return const Color(0xffdf2330);

      case 3:
        return const Color(0xff1964e6);
    }
    return Colors.white;
  }

  Widget tabBarview() {
    if (controller.signalLoad.isTrue &&
        controller.nateLoad.isTrue &&
        controller.zoomLoad.isTrue) {
      return Expanded(
        child: TabBarView(
          controller: _tabController,
          children: [
            ResultRanking2(),
            const SignalRanking(),
            const NateRanking(),
            const ZoomRanking(),
          ],
        ),
      );
    }
    return Container();
  }

  Widget updateTime() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('yyyy-MM-dd kk:mm').format(now);
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  alignment: Alignment.center,
                  height: 30,
                  width: 260,
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.alarm,
                        size: 18,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        formattedDate,
                        style: const TextStyle(
                            color: Colors.grey, fontFamily: 'ibm'),
                      ),
                      const SizedBox(width: 10),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                          alignment: Alignment.center,
                          width: 50,
                          height: 20,
                          color: indicatorColors(),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                controller.refreshRank();
                              },
                              icon: const Icon(Icons.refresh,
                                  size: 19, color: Colors.white),
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget topArea() {
    return Container(
      margin: const EdgeInsets.all(15),
      alignment: Alignment.centerLeft,
      child: const Text(
        '실시간 검색어 성공한 것 같습니다.',
        style: TextStyle(
            fontFamily: 'ibm',
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 25),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        // appBar: _appBar(),
        body: Obx(
          () {
            return Column(
              children: [
                // topArea(),
                tabBar(),
                updateTime(),
                tabBarview(),
              ],
            );
          },
        ),
      ),
    );
  }
}
