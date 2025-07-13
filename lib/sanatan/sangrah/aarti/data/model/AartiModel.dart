// To parse this JSON data, do
//
//     final aartiModel = aartiModelFromJson(jsonString);

import 'dart:convert';

AartiModel aartiModelFromJson(String str) => AartiModel.fromJson(json.decode(str));

String aartiModelToJson(AartiModel data) => json.encode(data.toJson());

class AartiModel {
  bool? status;
  List<AartiDataList>? data;
  String? msg;

  AartiModel({
    this.status,
    this.data,
    this.msg,
  });

  factory AartiModel.fromJson(Map<String, dynamic> json) => AartiModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<AartiDataList>.from(json["data"]!.map((x) => AartiDataList.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class AartiDataList {
  int? id;
  int? godId;
  String? title;
  String? descriptionTitle;
  DateTime? createdAt;

  AartiDataList({
    this.id,
    this.godId,
    this.title,
    this.descriptionTitle,
    this.createdAt,
  });

  factory AartiDataList.fromJson(Map<String, dynamic> json) => AartiDataList(
    id: json["id"],
    godId: json["god_id"],
    title: json["title"],
    descriptionTitle: json["description_title"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "god_id": godId,
    "title": title,
    "description_title": descriptionTitle,
    "created_at": createdAt?.toIso8601String(),
  };
}
