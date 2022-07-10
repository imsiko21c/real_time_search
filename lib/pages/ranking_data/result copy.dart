import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:html/parser.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/pages/show_news.dart';

class ResultRanking2 extends GetView<AppController> {
  ResultRanking2({Key? key}) : super(key: key);

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

  Widget newsContent(int index) {
    return Obx(() {
      if (controller.imageLoad.isTrue && controller.newsLoad.isTrue) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          height: 200,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                    bottom: BorderSide(
                        color: Colors.black.withOpacity(0.2), width: 0.25),
                    top: BorderSide(
                        color: Colors.black.withOpacity(0.2), width: 0.25),
                  ),
                ),
                child: Row(
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
                          color: Colors.purple),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    parseHtmlString(
                        controller.resultNewsModel[index].title.toString()),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'ibm',
                        color: Colors.black),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    SizedBox(
                        width: 100,
                        height: 100,
                        child: Image.network(
                          controller.newsImageModel[index].thumbnailUrl
                              .toString(),
                          fit: BoxFit.cover,
                        )),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Text(
                        parseHtmlString(controller
                            .resultNewsModel[index].description
                            .toString()),
                        maxLines: 5,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'ibm', height: 1.4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
    });
  }

  Widget newsList() {
    return Expanded(
      child: ListView.builder(
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
