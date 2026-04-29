import 'package:flutter/material.dart';
import '../models/news_article.dart';
import '../services/news_service.dart';

class NewsProvider with ChangeNotifier{
  NewsService _newsService = NewsService();
  List<NewsArticle> _articles = [];
  bool _isLoading = false;
  String? _error;

  List<NewsArticle> get articles => _articles;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String _country = '';
  String get country => _country;

  Future<void> fetchNews([String? destination]) async{
    _isLoading = true;
    _error = null;
    notifyListeners();

    if (destination != null) _country = destination;
    print(_country);

    try{
      print('news provider destination : $destination');
      _articles = await _newsService.getNews(destination?? _country);
    }catch (e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}