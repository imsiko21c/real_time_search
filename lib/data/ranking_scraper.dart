import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class LoadRanking {
  var url = Uri.parse(
      'https://search.zum.com/search.zum?method=uni&option=accu&qm=g_real1.news&real1_id=1');

  List<String> ranking = [];
  List<String> updown = [];

  Map<String, String> rankingData = {};

  Future<Map<String, String>> getData() async {
    ranking.clear();
    updown.clear();

    var res = await http.get(url);
    final body = res.body;
    final document = parser.parse(body);
    document
        .getElementById('issue_wrap')!
        .getElementsByClassName('issue-keyword-wrapper')
        .forEach((element) {
      rankingData[element.children[0].children[0].children[1].text] =
          element.children[0].children[0].children[2].text;
    });
    return rankingData;
  }
}
