import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/show_news.dart';

class SignalRanking extends GetView<AppController> {
  const SignalRanking({Key? key}) : super(key: key);

  Widget topText(String text) {
    return Text(
      text,
      style: const TextStyle(
          fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
    );
  }

  Widget middleArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(35, 15, 35, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            '실시간 인기 검색어',
            style: TextStyle(
                fontFamily: 'ibm',
                fontSize: 15.5,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
          Image.asset(
            'assets/images/signal_ci.png',
            width: 80,
          ),
        ],
      ),
    );
  }

  Widget checkLoadData(int index) {
    if (controller.signalLoad.isTrue) {
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
                color: const Color.fromARGB(255, 112, 191, 137),
                child: Text(
                  '${index + 1}',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                controller.signalLoad.isTrue
                    ? controller.signalRanking[index].keyword.toString()
                    : '',
                style: TextStyle(
                  color: Colors.black.withOpacity(0.6),
                  fontFamily: 'ibm',
                  // fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              height: 25,
              width: 30,
              child: upDownCheck(index),
            )
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

  Widget ranking() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 60),
        child: Obx(() => ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: controller.signalRanking.length,
              itemBuilder: ((context, index) {
                return GestureDetector(
                  child: checkLoadData(index),
                  onTap: () async {
                    await controller.newsLoading(
                        controller.signalRanking[index].keyword.toString());
                    if (controller.result.isNotEmpty) {
                      Get.to(() => ShowNews(
                            index: index,
                            keyword: controller.signalRanking[index].keyword
                                .toString(),
                          ));
                    }
                  },
                );
              }),
            )),
      ),
    );
  }

  Widget upDownCheck(int index) {
    switch (controller.signalRanking[index].state) {
      case 's':
        return SvgPicture.asset(
          'assets/svg/dash_icon.svg',
          width: 10,
        );

      case '-':
        return SvgPicture.asset(
          'assets/svg/down_arrow_icon.svg',
          width: 17,
          color: Colors.blue,
        );

      case '+':
        return SvgPicture.asset(
          'assets/svg/up_arrow_icon.svg',
          width: 17,
          color: Colors.red,
        );
      case 'n':
        return SvgPicture.asset(
          'assets/svg/plus_icon.svg',
          width: 15,
          color: Colors.green,
        );
    }
    return Container();
  }

  Widget pageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          height: 40,
          width: 100,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 10,
                height: 10,
                color: const Color.fromARGB(255, 112, 191, 137),
              ),
            ),
            const SizedBox(width: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 10,
                height: 10,
                color: Colors.grey,
              ),
            ),
            const SizedBox(width: 5),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Container(
                width: 10,
                height: 10,
                color: Colors.grey,
              ),
            ),
          ]),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            middleArea(),
            ranking(),
            pageIndicator(),
          ],
        ));
  }
}
