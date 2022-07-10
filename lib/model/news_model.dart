// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  NewsModel({
    this.title,
    this.originallink,
    this.link,
    this.description,
    this.pubDate,
  });

  String? title;
  String? originallink;
  String? link;
  String? description;
  String? pubDate;

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        title: json["title"],
        originallink: json["originallink"],
        link: json["link"],
        description: json["description"],
        pubDate: json["pubDate"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "originallink": originallink,
        "link": link,
        "description": description,
        "pubDate": pubDate,
      };
}
