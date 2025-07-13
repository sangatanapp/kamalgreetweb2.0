import 'dart:convert';

DarshanModel darshanModelFromJson(String str) =>
    DarshanModel.fromJson(json.decode(str));

String darshanModelToJson(DarshanModel data) => json.encode(data.toJson());

class DarshanModel {
  bool? status;
  List<DarshanDataList>? data;
  String? msg;

  DarshanModel({
    this.status,
    this.data,
    this.msg,
  });

  factory DarshanModel.fromJson(Map<String, dynamic> json) => DarshanModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<DarshanDataList>.from(
                json["data"]!.map((x) => DarshanDataList.fromJson(x))),
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

class DarshanDataList {
  int? id;
  String? title;
  String? description;
  String? godUrl;
  int? godId;
  String? createdAt;

  DarshanDataList({
    this.id,
    this.title,
    this.description,
    this.godUrl,
    this.godId,
    this.createdAt,
  });

  factory DarshanDataList.fromJson(Map<String, dynamic> json) =>
      DarshanDataList(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        godUrl: json["god_url"],
        godId: json["god_id"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "god_url": godUrl,
        "god_id": godId,
        "created_at": createdAt,
      };
}
