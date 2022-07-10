import 'dart:convert';

import 'package:cp949_dart/cp949_dart.dart' as cp949;
import 'package:get/get.dart';
import 'package:real_time_search/model/signal_ranking.dart';
import 'package:http/http.dart' as http;

class RankingRepository extends GetConnect {
  RankingRepository get to => Get.find();

  Map<String, String> nateRank = {};

  Future<List<SignalModel>> signalFatchData() async {
    final Response response = await get('https://api.signal.bz/news/realtime');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return List<SignalModel>.from(
              response.body['top10'].map((data) => SignalModel.fromJson(data)))
          .toList();
    }
  }

  Future<Map<String, String>> nateFatchData() async {
    http.Response response = await http
        .get(Uri.parse('http://nate.com/js/data/jsonLiveKeywordDataV1.js?v='));

    String jsonData = cp949.decodeString(response.body);
    var myJson = jsonDecode(jsonData);
    for (int i = 0; i < 10; i++) {
      nateRank[myJson[i][1]] = myJson[i][2];
    }
    return nateRank;
  }
}



