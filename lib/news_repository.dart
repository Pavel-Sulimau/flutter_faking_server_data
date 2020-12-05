import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_faking_server_data/config.dart';
import 'package:flutter_faking_server_data/news_article_model.dart';
import 'package:http/http.dart';

class NewsRepository {
  NewsRepository({
    @required Client httpClient,
  }) : _httpClient = httpClient;

  final _topHeadlinesUrl =
      'https://newsapi.org/v2/top-headlines?sources=bbc-news&apiKey=$newsApiKey&pageSize=15&page=1';
  final Client _httpClient;

  Future<List<NewsArticleModel>> getTopHeadlines() async {
    final response = await _httpClient.get(_topHeadlinesUrl);

    if (response.statusCode == 200) {
      final Iterable<dynamic> rawArticles =
          (json.decode(response.body) as Map<String, dynamic>)['articles'];
      final articles =
          rawArticles.map((a) => NewsArticleModel.fromJson(a as Map<String, dynamic>)).toList();
      return articles;
    } else {
      throw Exception(
        "Request failed. It may be because you didn't use the right API Key. Please check it.",
      );
    }
  }
}
