// To parse this JSON data, do
//
//     final mantraModel = mantraModelFromJson(jsonString);

import 'dart:convert';

MantraModel mantraModelFromJson(String str) =>
    MantraModel.fromJson(json.decode(str));

String mantraModelToJson(MantraModel data) => json.encode(data.toJson());

class MantraModel {
  bool? status;
  List<MantraListData>? data;
  String? msg;

  MantraModel({
    this.status,
    this.data,
    this.msg,
  });

  factory MantraModel.fromJson(Map<String, dynamic> json) => MantraModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<MantraListData>.from(
                json["data"]!.map((x) => MantraListData.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class MantraListData {
  int? id;
  int? godId;
  String? title;
  String? description;
  String? audioLink;

  MantraListData({
    this.id,
    this.godId,
    this.title,
    this.description,
    this.audioLink,
  });

  factory MantraListData.fromJson(Map<String, dynamic> json) => MantraListData(
        id: json["id"],
        godId: json["god_id"],
        title: json["title"],
        description: json["description"],
        audioLink: json["audio_link"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "god_id": godId,
        "title": title,
        "description": description,
        "audio_link": audioLink,
      };
}
