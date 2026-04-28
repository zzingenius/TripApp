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

  Future<void> fetchNews() async{
    print('fetchNews 들어옴');
    _isLoading = true;
    _error = null;
    notifyListeners();

    try{
      _articles = await _newsService.getNews();
    }catch (e){
      _error = e.toString();
    }finally{
      _isLoading = false;
      notifyListeners();
    }
  }
}