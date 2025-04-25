// To parse this JSON data, do
//
//     final sanatanGodListModel = sanatanGodListModelFromJson(jsonString);

import 'dart:convert';

SanatanGodListModel sanatanGodListModelFromJson(String str) => SanatanGodListModel.fromJson(json.decode(str));

String sanatanGodListModelToJson(SanatanGodListModel data) => json.encode(data.toJson());

class SanatanGodListModel {
  bool? status;
  List<SanatanGodDetail>? data;
  String? msg;

  SanatanGodListModel({
    this.status,
    this.data,
    this.msg,
  });

  factory SanatanGodListModel.fromJson(Map<String, dynamic> json) => SanatanGodListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<SanatanGodDetail>.from(json["data"]!.map((x) => SanatanGodDetail.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class SanatanGodDetail {
  int? id;
  String? title;
  String? thumbnail;
  String? description;
  DateTime? createdAt;

  SanatanGodDetail({
    this.id,
    this.title,
    this.thumbnail,
    this.description,
    this.createdAt,
  });

  factory SanatanGodDetail.fromJson(Map<String, dynamic> json) => SanatanGodDetail(
    id: json["id"],
    title: json["title"],
    thumbnail: json["thumbnail"],
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "thumbnail": thumbnail,
    "description": description,
    "created_at": createdAt?.toIso8601String(),
  };
}
