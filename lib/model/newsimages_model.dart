// To parse this JSON data, do
//
//     final newsImageModel = newsImageModelFromJson(jsonString);

import 'dart:convert';

NewsImageModel newsImageModelFromJson(String str) =>
    NewsImageModel.fromJson(json.decode(str));

String newsImageModelToJson(NewsImageModel data) => json.encode(data.toJson());

class NewsImageModel {
  NewsImageModel({
    this.collection,
    this.datetime,
    this.displaySitename,
    this.docUrl,
    this.height,
    this.imageUrl,
    this.thumbnailUrl,
    this.width,
  });

  String? collection;
  DateTime? datetime;
  String? displaySitename;
  String? docUrl;
  int? height;
  String? imageUrl;
  String? thumbnailUrl;
  int? width;

  factory NewsImageModel.fromJson(Map<String, dynamic> json) => NewsImageModel(
        collection: json["collection"],
        datetime: DateTime.parse(json["datetime"]),
        displaySitename: json["display_sitename"],
        docUrl: json["doc_url"],
        height: json["height"],
        imageUrl: json["image_url"],
        thumbnailUrl: json["thumbnail_url"],
        width: json["width"],
      );

  Map<String, dynamic> toJson() => {
        "collection": collection,
        "datetime": datetime!.toIso8601String(),
        "display_sitename": displaySitename,
        "doc_url": docUrl,
        "height": height,
        "image_url": imageUrl,
        "thumbnail_url": thumbnailUrl,
        "width": width,
      };
}
