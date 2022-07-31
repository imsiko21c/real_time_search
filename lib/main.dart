import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:real_time_search/binddings/binddings.dart';
import 'package:real_time_search/pages/home.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'MyApp',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      initialBinding: ControllerBindings(),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => RealTime()),
      ],
    );
  }
}
