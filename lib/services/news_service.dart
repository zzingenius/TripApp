//news 데이터 획득을 위한 네트워킹
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_pjt/models/news_article.dart';
import 'package:http/http.dart' as http;

class NewsService {
  static const String _baseUrl = 'https://newsapi.org/v2';
  static String get _apiKey => dotenv.env['API_KEY'] ?? '';

  //네트워킹을 위해서 호출되는 함수
  Future<List<NewsArticle>> getNews(String destination) async{
    try{
      final response = await http.get(Uri.parse('$_baseUrl/everything?q=$destination&page=1&pageSize=10&apiKey=$_apiKey'));
      if(response.statusCode == 200){
        final data = json.decode(response.body);
        final articles = data['articles'] as List;

        return articles.map((article) => NewsArticle.fromJson(article)).toList();
      }else{
        debugPrint('ERROR ${response.statusCode}');
       throw Exception('error news networking...1');
      }
    } catch(e){
      print('error $e');
      throw Exception('error news networking...2');

    }
  }
}