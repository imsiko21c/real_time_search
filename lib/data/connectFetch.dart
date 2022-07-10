import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:real_time_search/model/news_model.dart';
import 'package:real_time_search/model/newsimages_model.dart';

import '../model/mainnews.dart';

class ConnectFetch {
  ConnectFetch(this.query);
  String? query;

  Map<String, String> apiKey = {
    'X-Naver-Client-Id': 'DzYuMpZkdaS_6wZ7zaxu',
    'X-Naver-Client-Secret': 'N958GHgTNu'
  };

  Map<String, String> kakoApiKey = {
    'Authorization': 'KakaoAK 77a50428335924dfced5b227d962f1e4'
  };

  Future<List<NewsModel>> newsFetch() async {
    var url = Uri.parse(
        'https://openapi.naver.com/v1/search/news.json?query=$query&display=15&start=1&sort=sim');

    var response = await http.get(url, headers: apiKey);

    String jsonData = response.body;
    var myJson = jsonDecode(jsonData);

    return List<NewsModel>.from(
      myJson['items'].map(
        (data) => NewsModel.fromJson(data),
      ),
    ).toList();
  }

  Future<List<NewsImageModel>> newsImageFetch() async {
    var url = Uri.parse(
        'https://dapi.kakao.com/v2/search/image?sort=accuracy&page=1&size=10&query=$query');

    var response = await http.get(url, headers: kakoApiKey);

    String jsonData = response.body;
    var myJson = jsonDecode(jsonData);

    return List<NewsImageModel>.from(
      myJson['documents'].map(
        (data) => NewsImageModel.fromJson(data),
      ),
    ).toList();
  }
}
