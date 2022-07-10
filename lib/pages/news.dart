import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/newscontroller.dart';

class News extends GetView<NewsConttoler> {
  const News({Key? key}) : super(key: key);

  Widget topTitle(BuildContext context, String title, String krTitle) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 20, 20, 3),
      width: MediaQuery.of(context).size.width,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 17, fontFamily: 'ibm', fontWeight: FontWeight.bold),
          ),
          Text(
            krTitle,
            style: const TextStyle(
                fontSize: 14, fontFamily: 'ibm', fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget newsThumbnail(int index) {
    return Container(
      margin: const EdgeInsets.only(left: 20),
      child: Column(
        children: [
          Container(
            width: 150,
            height: 85,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Image.network(
                controller.mainNews[index].urlToImage.toString(),
                fit: BoxFit.cover,
              ),
            ),
          ),
          newTitle(index),
        ],
      ),
    );
  }

  Widget newTitle(int index) {
    return Container(
      height: 60,
      width: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 0.5,
              blurRadius: 10,
              offset: Offset(0, 1))
        ],
        border: Border(
          left: BorderSide(color: Colors.black.withOpacity(0.25), width: 0.3),
          right: BorderSide(color: Colors.black.withOpacity(0.25), width: 0.3),
          bottom: BorderSide(color: Colors.black.withOpacity(0.25), width: 0.3),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          controller.mainNews[index].title.toString(),
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 13, fontFamily: 'ibm'),
        ),
      ),
    );
  }

  Widget topNews() {
    return SizedBox(
      height: 150,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, index) {
            return newsThumbnail(index);
          }),
    );
  }

  Widget middleNews() {
    return Expanded(
      child: ListView.builder(
          itemCount: 5,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.all(8.0),
              height: 60,
              width: 100,
              color: Colors.amber,
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            topTitle(context, 'Now Issue', '실시간 검색어'),
            Container(
              height: 100,
              color: Colors.blueAccent,
            ),
            topTitle(context, 'Today News', '오늘의 주요뉴스'),
            topNews(),
            topTitle(context, 'Top News', '오늘의 인기뉴스'),
            middleNews(),
          ],
        ),
      ),
    );
  }
}
