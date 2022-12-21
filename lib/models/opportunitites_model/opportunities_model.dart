// To parse this JSON data, do
//
//     final OpprotunitiesModel = OpprotunitiesModelFromJson(jsonString);

import 'dart:convert';

List<OpportunitiesModel> opprotunitiesModelFromJson(String str) =>
    List<OpportunitiesModel>.from(
        json.decode(str).map((x) => OpportunitiesModel.fromJson(x)));

String opprotunitiesModelToJson(List<OpportunitiesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OpportunitiesModel {
  OpportunitiesModel(
      {required this.createdBy,
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

  factory OpportunitiesModel.fromJson(Map<String, dynamic> json) =>
      OpportunitiesModel(
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
        "id": id.toString()
      };
}
