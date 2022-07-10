import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/show_news.dart';

class ResultRanking extends GetView<AppController> {
  ResultRanking({Key? key}) : super(key: key);

  Widget topArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 0, 18, 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            '실시간 검색어',
            style: TextStyle(
              fontFamily: 'ibm',
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget realTimeRanking(BuildContext context) {
    return Obx(() {
      if (controller.result.isNotEmpty) {
        return DefaultTextStyle(
          style: const TextStyle(
              fontSize: 23,
              fontFamily: 'ibm',
              color: Colors.black,
              fontWeight: FontWeight.bold),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                '[',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width - 90,
                height: 50,
                child: AnimatedTextKit(
                  animatedTexts: [
                    for (int i = 0; i < controller.result.length; i++)
                      RotateAnimatedText(
                        controller.result[i],
                      ),
                  ],
                  onTap: () {},
                  repeatForever: true,
                ),
              ),
              const Text(
                ']',
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              )
            ],
          ),
        );
      } else {
        return Container();
      }
    });
  }

  Widget middleArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 15, 35, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '지금! 실시간 검색어',
            style: TextStyle(
                fontFamily: 'ibm',
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Image.asset(
            'assets/images/now.png',
            width: 60,
          ),
        ],
      ),
    );
  }

  Widget checkLoadData(int index) {
    if (controller.nateLoad.isTrue) {
      return Container(
        alignment: Alignment.centerLeft,
        height: 50,
        width: 150,
        decoration: const BoxDecoration(
            border:
                Border(bottom: BorderSide(color: Colors.grey, width: 0.25))),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Container(
                alignment: Alignment.center,
                height: 22,
                width: 22,
                color: Colors.purple.withOpacity(0.7),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                controller.nateLoad.isTrue
                    ? controller.result[index].toString()
                    : '',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontFamily: 'ibm',
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: Colors.purple,
        ),
      );
    }
  }

  // Widget rankings(BuildContext context) {
  //   return Obx(() => Expanded(
  //         child: ListWheelScrollView.useDelegate(
  //           physics: const FixedExtentScrollPhysics(),
  //           useMagnifier: true,
  //           magnification: 1.2,
  //           squeeze: 0.7,
  //           perspective: 0.01,
  //           diameterRatio: 6,
  //           onSelectedItemChanged: ((value) {}),
  //           itemExtent: 80,
  //           childDelegate: ListWheelChildBuilderDelegate(
  //             childCount: controller.result.length,
  //             builder: (context, index) => Container(
  //               width: 200,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(10),
  //                 color: Colors.grey,
  //               ),
  //               child: Center(
  //                 child: Text(controller.result[index]),
  //               ),
  //             ),
  //           ),
  //         ),
  //       ));
  // }

  Widget ranking() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Obx(() => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.result.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  child: checkLoadData(index),
                  onTap: () async {
                    await controller
                        .newsLoading(controller.result[index].toString());
                    if (controller.result.isNotEmpty) {
                      Get.to(() => ShowNews(
                            index: index,
                            keyword: controller.result[index].toString(),
                          ));
                    }
                  },
                );
              }),
            )),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            middleArea(),
            ranking(),
          ],
        ),
      ),
    );
  }
}
