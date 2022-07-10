import 'dart:convert';

SignalModel rankingModelFromJson(String str) =>
    SignalModel.fromJson(json.decode(str));

String rankingModelToJson(SignalModel data) => json.encode(data.toJson());

class SignalModel {
  SignalModel({
    this.rank,
    this.keyword,
    this.state,
  });

  int? rank;
  String? keyword;
  String? state;

  factory SignalModel.fromJson(Map<String, dynamic> json) => SignalModel(
        rank: json["rank"],
        keyword: json["keyword"],
        state: json["state"],
      );

  Map<String, dynamic> toJson() => {
        "rank": rank,
        "keyword": keyword,
        "state": state,
      };
}
