//뉴스 기사 하나 추상화 dto
class NewsArticle{
  String title;
  String description;
  String url;
  String? urlToImage;
  String publishedAt;
  String? source;

  NewsArticle({
    required this.title,
    this.description = '기사 없음',
    required this.url,
    required this.publishedAt,
    this.urlToImage,
    this.source,
  });

  factory NewsArticle.fromJson(Map<String, dynamic> json){
    return NewsArticle(
        title: json['title'],
        description: json['description'] ?? '기사 없음',
        url: json['url'],
        publishedAt: json['publishedAt'],
        urlToImage: json['urlToImage'],
        source: json['source']?['name'],
    );

  }
}