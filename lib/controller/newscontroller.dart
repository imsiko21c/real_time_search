import 'package:get/get.dart';
import 'package:real_time_search/data/news_repository.dart';
import 'package:real_time_search/model/mainnews.dart';

class NewsConttoler extends GetxController {
  static NewsConttoler get to => Get.find();

  RxList<Mainnews> mainNews = RxList<Mainnews>.empty(growable: true);

  @override
  void onInit() {
    mainNewsFetch();
    super.onInit();
  }

  void mainNewsFetch() async {
    List<Mainnews> temp = await NewsRepository().mainNewsFetch();
    mainNews(temp);
  }
}
