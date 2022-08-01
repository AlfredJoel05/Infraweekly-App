// To parse this JSON data, do
//
//     final PreviousWeekModel = PreviousWeekModelFromJson(jsonString);

import 'dart:convert';

List<PreviousWeekModel> previousWeekModelFromJson(String str) =>
    List<PreviousWeekModel>.from(
        json.decode(str).map((x) => PreviousWeekModel.fromJson(x)));

String previousWeekModelToJson(List<PreviousWeekModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PreviousWeekModel {
  PreviousWeekModel({
    required this.createdBy,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.media,
  });

  String createdBy;
  List<int> createdAt;
  String title;
  String description;
  String media;

  factory PreviousWeekModel.fromJson(Map<String, dynamic> json) =>
      PreviousWeekModel(
        createdBy: json["createdBy"],
        createdAt: List<int>.from(json["createdAt"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        media: json["media"],
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdAt": List<dynamic>.from(createdAt.map((x) => x)),
        "title": title,
        "description": description,
        "media": media,
      };
}
