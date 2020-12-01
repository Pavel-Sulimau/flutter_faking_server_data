import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'news_article_model.g.dart';

@JsonSerializable()
class NewsArticleModel {
  const NewsArticleModel({
    @required this.title,
    @required this.description,
    @required this.imageUrl,
    @required this.publishingDateTime,
  });

  factory NewsArticleModel.fromJson(Map<String, dynamic> json) =>
      _$NewsArticleModelFromJson(json);

  final String title;
  final String description;
  @JsonKey(name: 'urlToImage')
  final String imageUrl;
  @JsonKey(name: 'publishedAt')
  final DateTime publishingDateTime;

  Map<String, dynamic> toJson() => _$NewsArticleModelToJson(this);
}
