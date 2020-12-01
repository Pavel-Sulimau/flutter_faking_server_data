// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_article_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NewsArticleModel _$NewsArticleModelFromJson(Map<String, dynamic> json) {
  return NewsArticleModel(
    title: json['title'] as String,
    description: json['description'] as String,
    imageUrl: json['urlToImage'] as String,
    publishingDateTime: json['publishedAt'] == null
        ? null
        : DateTime.parse(json['publishedAt'] as String),
  );
}

Map<String, dynamic> _$NewsArticleModelToJson(NewsArticleModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'description': instance.description,
      'urlToImage': instance.imageUrl,
      'publishedAt': instance.publishingDateTime?.toIso8601String(),
    };
