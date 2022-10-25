// To parse this JSON data, do
//
//     final ProjectsNewsModel = ProjectsNewsModelFromJson(jsonString);

import 'dart:convert';

List<ProjectsNewsModel> projectsNewsModelFromJson(String str) =>
    List<ProjectsNewsModel>.from(
        json.decode(str).map((x) => ProjectsNewsModel.fromJson(x)));

String projectsNewsModelToJson(List<ProjectsNewsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProjectsNewsModel {
  ProjectsNewsModel({
      required this.createdBy,
      required this.createdAt,
      required this.title,
      required this.description,
      required this.media,
      required this.link
      });

  String createdBy;
  List<int> createdAt;
  String title;
  String description;
  String media;
  String link;

  factory ProjectsNewsModel.fromJson(Map<String, dynamic> json) =>
      ProjectsNewsModel(
        createdBy: json["createdBy"],
        createdAt: List<int>.from(json["createdAt"].map((x) => x)),
        title: json["title"],
        description: json["description"],
        media: json["media"],
        link: json["link"]
      );

  Map<String, dynamic> toJson() => {
        "createdBy": createdBy,
        "createdAt": List<dynamic>.from(createdAt.map((x) => x)),
        "title": title,
        "description": description,
        "media": media,
        "link": link
      };
}
