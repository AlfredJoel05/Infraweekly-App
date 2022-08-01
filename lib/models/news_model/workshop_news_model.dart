// To parse this JSON data, do
//
//     final WorkshopNewsModel = WorkshopNewsModelFromJson(jsonString);

import 'dart:convert';

List<WorkshopNewsModel> workshopNewsModelFromJson(String str) =>
    List<WorkshopNewsModel>.from(
        json.decode(str).map((x) => WorkshopNewsModel.fromJson(x)));

String workshopNewsModelToJson(List<WorkshopNewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class WorkshopNewsModel {
  WorkshopNewsModel({
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

  factory WorkshopNewsModel.fromJson(Map<String, dynamic> json) =>
      WorkshopNewsModel(
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
