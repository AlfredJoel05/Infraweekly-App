// To parse this JSON data, do
//
//     final ResearchModel = ResearchModelFromJson(jsonString);

import 'dart:convert';

List<ResearchModel> researchModelFromJson(String str) =>
    List<ResearchModel>.from(
        json.decode(str).map((x) => ResearchModel.fromJson(x)));

String researchModelToJson(List<ResearchModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ResearchModel {
  ResearchModel({
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

  factory ResearchModel.fromJson(Map<String, dynamic> json) =>
      ResearchModel(
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
