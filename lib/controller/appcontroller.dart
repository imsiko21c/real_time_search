import 'package:get/get.dart';
import 'package:real_time_search/data/ranking_repository.dart';
import 'package:real_time_search/data/ranking_scraper.dart';
import 'package:real_time_search/model/news_model.dart';
import 'package:real_time_search/model/newsimages_model.dart';
import 'package:real_time_search/model/signal_ranking.dart';
import '../data/connectFetch.dart';

enum RouteName { realtime, news, settings }

class AppController extends GetxController {
  static AppController get to => Get.find();

  RxList<String> zoomTitle = RxList<String>.empty(growable: true);
  RxList<String> zoomUpdown = RxList<String>.empty(growable: true);
  LoadRanking loadRanking = LoadRanking();

  RxList<String> nateTitle = RxList<String>.empty(growable: true);
  RxList<String> nateUpDown = RxList<String>.empty(growable: true);
  RxList<SignalModel> signalRanking = RxList<SignalModel>.empty(growable: true);
  RxList<String> result = RxList<String>.empty(growable: true);
  RxList<NewsModel> newsModel = RxList<NewsModel>.empty(growable: true);
  RxList<NewsImageModel> newsImageModel =
      RxList<NewsImageModel>.empty(growable: true);

  RxList<NewsModel> resultNewsModel = RxList<NewsModel>.empty(growable: true);

  RxInt currentPage = 0.obs;
  RxInt currentTab = 0.obs;
  RxBool signalLoad = false.obs;
  RxBool nateLoad = false.obs;
  RxBool zoomLoad = false.obs;
  RxBool imageLoad = false.obs;
  RxBool newsLoad = false.obs;

  @override
  void onInit() async {
    await signalRankingLoad();
    await nateRankingLoad();
    await zoomRankingLoad();

    if (nateLoad.isTrue && signalLoad.isTrue && zoomLoad.isTrue) {
      resultRanking();
    }
    super.onInit();
  }

  Future<void> signalRankingLoad() async {
    List<SignalModel> signalRankingTemp =
        await RankingRepository().to.signalFatchData();
    signalRanking(signalRankingTemp);
    signalLoad(true);
  }

  Future<void> nateRankingLoad() async {
    Map<String, String> temp = await RankingRepository().to.nateFatchData();
    nateTitle.addAll(temp.keys);
    nateUpDown.addAll(temp.values);
    nateLoad(true);
  }

  Future<void> zoomRankingLoad() async {
    Map<String, String> temp = await loadRanking.getData();
    zoomTitle.addAll(temp.keys);
    zoomUpdown.addAll(temp.values);
    zoomLoad(true);
  }

  void changePage(int index) {
    currentPage(index);
  }

  void refreshRank() async {
    signalRanking.clear();
    nateTitle.clear();
    nateUpDown.clear();
    zoomTitle.clear();
    zoomUpdown.clear();
    result.clear();
    newsImageModel.clear();
    resultNewsModel.clear();

    imageLoad(false);
    newsLoad(false);

    await signalRankingLoad();
    await nateRankingLoad();
    await zoomRankingLoad();

    if (nateLoad.isTrue && signalLoad.isTrue && zoomLoad.isTrue) {
      await resultRanking();
    }
  }

  Future<void> resultRanking() async {
    for (int i = 0; i < signalRanking.length; i++) {
      for (int j = 0; j < nateTitle.length; j++) {
        if (signalRanking[i].keyword == nateTitle[j]) {
          result.add(signalRanking[i].keyword.toString());
        }
      }
    }

    for (int i = 0; i < signalRanking.length; i++) {
      for (int j = 0; j < zoomTitle.length; j++) {
        if (signalRanking[i].keyword == zoomTitle[j]) {
          result.add(zoomTitle[j].toString());
        }
      }
    }

    for (int i = 0; i < nateTitle.length; i++) {
      for (int j = 0; j < zoomTitle.length; j++) {
        if (nateTitle[i] == zoomTitle[j]) {
          result.add(nateTitle[i].toString());
        }
      }
    }

    var temps = result.toSet();
    result(temps.toList());

    resultNewsLoading();
    imageLoading();
  }

  Future<void> imageLoading() async {
    newsImageModel.clear();
    for (int i = 0; i < result.length; i++) {
      List<NewsImageModel> temps2 =
          await ConnectFetch(result[i]).newsImageFetch();
      newsImageModel.add(temps2[0]);
    }
    imageLoad(true);
    print(newsImageModel.length);
  }

  Future<void> resultNewsLoading() async {
    resultNewsModel.clear();

    for (int i = 0; i < result.length; i++) {
      List<NewsModel> temps = await ConnectFetch(result[i]).newsFetch();
      resultNewsModel.add(temps[0]);
    }
    newsLoad(true);
  }

  Future<void> newsLoading(String query) async {
    newsModel.clear();
    List<NewsModel> temps = await ConnectFetch(query).newsFetch();
    newsModel(temps);
  }

  void changeTab(int index) {
    currentTab(index);
  }
}
