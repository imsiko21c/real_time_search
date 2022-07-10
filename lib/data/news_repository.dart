//import 'package:cp949_dart/cp949_dart.dart' as cp949;
import 'package:get/get.dart';
import 'package:real_time_search/model/mainnews.dart';

class NewsRepository extends GetConnect {
  NewsRepository get to => Get.find();

  Future<List<Mainnews>> mainNewsFetch() async {
    final Response response = await get(
        'https://newsapi.org/v2/top-headlines?country=kr&apiKey=a7cd253269a74cdabf19f29957831e75');

    if (response.status.hasError) {
      return Future.error(response.statusText.toString());
    } else {
      return List<Mainnews>.from(
              response.body['articles'].map((data) => Mainnews.fromJson(data)))
          .toList();
    }
  }
}
