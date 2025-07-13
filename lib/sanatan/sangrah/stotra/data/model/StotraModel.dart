// To parse this JSON data, do
//
//     final stotraModel = stotraModelFromJson(jsonString);

import 'dart:convert';

StotraModel stotraModelFromJson(String str) => StotraModel.fromJson(json.decode(str));

String stotraModelToJson(StotraModel data) => json.encode(data.toJson());

class StotraModel {
  bool? status;
  List<StotraListData>? data;
  String? msg;

  StotraModel({
    this.status,
    this.data,
    this.msg,
  });

  factory StotraModel.fromJson(Map<String, dynamic> json) => StotraModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<StotraListData>.from(json["data"]!.map((x) => StotraListData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class StotraListData {
  int? id;
  int? godId;
  String? title;
  String? descriptionTitle;
  DateTime? createdAt;

  StotraListData({
    this.id,
    this.godId,
    this.title,
    this.descriptionTitle,
    this.createdAt,
  });

  factory StotraListData.fromJson(Map<String, dynamic> json) => StotraListData(
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
