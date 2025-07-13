// To parse this JSON data, do
//
//     final chaleesaModel = chaleesaModelFromJson(jsonString);

import 'dart:convert';

ChaleesaModel chaleesaModelFromJson(String str) =>
    ChaleesaModel.fromJson(json.decode(str));

String chaleesaModelToJson(ChaleesaModel data) => json.encode(data.toJson());

class ChaleesaModel {
  bool? status;
  List<ChaleesaListData>? data;
  String? msg;

  ChaleesaModel({
    this.status,
    this.data,
    this.msg,
  });

  factory ChaleesaModel.fromJson(Map<String, dynamic> json) => ChaleesaModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<ChaleesaListData>.from(
                json["data"]!.map((x) => ChaleesaListData.fromJson(x))),
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

class ChaleesaListData {
  int? id;
  int? godId;
  String? title;
  String? descriptionTitle;
  DateTime? createdAt;

  ChaleesaListData({
    this.id,
    this.godId,
    this.title,
    this.descriptionTitle,
    this.createdAt,
  });

  factory ChaleesaListData.fromJson(Map<String, dynamic> json) =>
      ChaleesaListData(
        id: json["id"],
        godId: json["god_id"],
        title: json["title"],
        descriptionTitle: json["description_title"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "god_id": godId,
        "title": title,
        "description_title": descriptionTitle,
        "created_at": createdAt?.toIso8601String(),
      };
}
