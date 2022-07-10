import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/show_news.dart';

class ResultRanking extends GetView<AppController> {
  ResultRanking({Key? key}) : super(key: key);

  Widget middleArea() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'NOW! 이슈 뉴스',
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

  Widget rankingText(int index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Container(
            alignment: Alignment.center,
            width: 22,
            height: 22,
            color: Colors.purple,
            child: Text(
              '${index + 1}',
              style: const TextStyle(
                  fontSize: 13,
                  fontFamily: 'ibm',
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          controller.result[index].toString(),
          style: const TextStyle(
              fontSize: 14,
              fontFamily: 'ibm',
              color: Colors.purple,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget newsSummary(int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 200,
            child: Text(
              parseHtmlString(
                  controller.resultNewsModel[index].title.toString()),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'ibm',
                  color: Colors.black.withOpacity(0.85)),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Container(
                width: 60,
                height: 60,
                child: Image.network(
                  controller.newsImageModel[index].thumbnailUrl.toString(),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget newsContent(int index) {
    return Obx(() {
      if (controller.imageLoad.isTrue && controller.newsLoad.isTrue) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 35),
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(0.3), width: 0.25),
                    top: BorderSide(
                        color: Colors.black.withOpacity(0.3), width: 0.25),
                  ),
                ),
                child: rankingText(index),
              ),
              newsSummary(index),
            ],
          ),
        );
      } else {
        return const Padding(
          padding: EdgeInsets.all(20.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget newsList() {
    return Expanded(
      child: Obx(() {
        if (controller.imageLoad.isTrue && controller.newsLoad.isTrue) {
          return ListView.builder(
            itemCount: controller.result.length,
            itemBuilder: (context, index) {
              return GestureDetector(
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
                  child: newsContent(index));
            },
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      }),
    );
  }

  String parseHtmlString(String htmlString) {
    try {
      final document = parse(htmlString);
      final String parsedString =
          parse(document.body!.text).documentElement!.text;

      return parsedString;
    } catch (e) {
      return htmlString;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            middleArea(),
            newsList(),
          ],
        ),
      ),
    );
  }
}
