import 'package:get/get.dart';
import 'package:real_time_search/controller/appcontroller.dart';
import 'package:real_time_search/controller/newscontroller.dart';
import 'package:real_time_search/data/ranking_repository.dart';

class ControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(RankingRepository(), permanent: true);
    Get.put(AppController());
    Get.put(NewsConttoler());
  }
}
