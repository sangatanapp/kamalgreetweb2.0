// To parse this JSON data, do
//
//     final tagListModel = tagListModelFromJson(jsonString);

import 'dart:convert';

TagListModel tagListModelFromJson(String str) =>
    TagListModel.fromJson(json.decode(str));

String tagListModelToJson(TagListModel data) => json.encode(data.toJson());

class TagListModel {
  bool status;
  List<TagName> tagName;
  String tagId;
  String msg;

  TagListModel({
    required this.status,
    required this.tagName,
    required this.tagId,
    required this.msg,
  });

  factory TagListModel.fromJson(Map<String, dynamic> json) => TagListModel(
        status: json["status"],
        tagName:
            List<TagName>.from(json["tagName"].map((x) => TagName.fromJson(x))),
        tagId: json["tagId"],
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "tagName": List<dynamic>.from(tagName.map((x) => x.toJson())),
        "tagId": tagId,
        "msg": msg,
      };
}

class TagName {
  int id;
  String tagName;
  String tagImageurl;
  int tagPosition;
  DateTime createdAt;
  DateTime updatedAt;
  int status;
  String language;
  String category;
  String fieldName;
  String displayTag;

  TagName({
    required this.id,
    required this.tagName,
    required this.tagImageurl,
    required this.tagPosition,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.language,
    required this.category,
    required this.fieldName,
    required this.displayTag,
  });

  factory TagName.fromJson(Map<String, dynamic> json) => TagName(
        id: json["id"],
        tagName: json["tag_name"],
        tagImageurl: json["tag_imageurl"],
        tagPosition: json["tag_position"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        status: json["status"],
        language: json["language"],
        category: json["category"],
        fieldName: json["field_name"],
        displayTag: json["display_tag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag_name": tagName,
        "tag_imageurl": tagImageurl,
        "tag_position": tagPosition,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "status": status,
        "language": language,
        "category": category,
        "field_name": fieldName,
        "display_tag": displayTag
      };
}
