// To parse this JSON data, do
//
//     final SeminarNewsModel = SeminarNewsModelFromJson(jsonString);

import 'dart:convert';

List<SeminarNewsModel> seminarNewsModelFromJson(String str) =>
    List<SeminarNewsModel>.from(
        json.decode(str).map((x) => SeminarNewsModel.fromJson(x)));

String seminarNewsModelToJson(List<SeminarNewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SeminarNewsModel {
  SeminarNewsModel({
    required this.createdBy,
    required this.createdAt,
    required this.title,
    required this.description,
    required this.media,
    required this.link,
    required this.id
  });

  String createdBy;
  List<int> createdAt;
  String title;
  String description;
  String media;
  String link;
  String id;

  factory SeminarNewsModel.fromJson(Map<String, dynamic> json) =>
      SeminarNewsModel(
        createdBy: json["createdBy"],
        createdAt: List<int>.from(json["createdAt"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        media: json["media"],
        link: json["link"],
        id: json["id"].toString()
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdAt": List<dynamic>.from(createdAt.map((x) => x)),
        "title": title,
        "description": description,
        "media": media,
        "link": link,
        "id": id,
      };
}
