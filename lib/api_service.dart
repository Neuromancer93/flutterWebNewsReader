import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_web_news_reader/models/article_model.dart';

class APIService {
  final String _baseUrl = 'api.nytimes.com';
  static const String API_KEY = 'R88iILCMlBL0kkyzvoCi8XklKFF0NXqh';

  Future<List<Article>> fetchArticlesBySection(String section) async {
    Map<String, String> parameters = {
      'api-key': API_KEY,
    };
    Uri uri = Uri.https(
      _baseUrl,
      '/svc/topstories/v2/$section.json',
      parameters,
    );
    try {
      var response = await http.get(uri);
      Map<String, dynamic> data = json.decode(response.body);
      List<Article> articles = [];
      data['results'].forEach(
        (articleMap) => articles.add(Article.fromMap(articleMap)),
      );
      return articles;
    } catch (err) {
      throw err.toString();
    }
  }
}
