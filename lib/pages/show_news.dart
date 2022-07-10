import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ShowNews extends StatelessWidget {
  ShowNews({Key? key, this.index, this.keyword}) : super(key: key);

  int? index;
  String? keyword;
  AppController controller = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
        shadowColor: Colors.black,
        centerTitle: true,
        title: Text(
          keyword.toString(),
          style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: 'ibm'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.back();
        },
        child: const Icon(Icons.arrow_back),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Obx(() {
        return WebView(
          initialUrl: controller.newsModel[0].link,
          javascriptMode: JavascriptMode.unrestricted,
        );
      }),
    );
  }
}
