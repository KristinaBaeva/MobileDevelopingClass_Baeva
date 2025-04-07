import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/news.dart';

class NewsService {
  static Future<List<News>> fetchNews() async {
    final response = await http.get(Uri.parse(
        'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90'));

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      return body.map((dynamic item) => News.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load news');
    }
  }
}