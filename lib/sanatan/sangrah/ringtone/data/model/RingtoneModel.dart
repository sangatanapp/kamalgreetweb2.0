// To parse this JSON data, do
//
//     final ringtoneModel = ringtoneModelFromJson(jsonString);

import 'dart:convert';

RingtoneModel ringtoneModelFromJson(String str) => RingtoneModel.fromJson(json.decode(str));

String ringtoneModelToJson(RingtoneModel data) => json.encode(data.toJson());

class RingtoneModel {
  bool? status;
  List<RingtoneListData>? postData;
  String? msg;

  RingtoneModel({
    this.status,
    this.postData,
    this.msg,
  });

  factory RingtoneModel.fromJson(Map<String, dynamic> json) => RingtoneModel(
    status: json["status"],
    postData: json["post_data"] == null ? [] : List<RingtoneListData>.from(json["post_data"]!.map((x) => RingtoneListData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "post_data": postData == null ? [] : List<dynamic>.from(postData!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class RingtoneListData {
  int? id;
  int? godId;
  String? title;
  String? description;
  String? audioLink;
  bool? isDeleted;
  bool? isMessagetone;

  RingtoneListData({
    this.id,
    this.godId,
    this.title,
    this.description,
    this.audioLink,
    this.isDeleted,
    this.isMessagetone,
  });

  factory RingtoneListData.fromJson(Map<String, dynamic> json) => RingtoneListData(
    id: json["id"],
    godId: json["god_id"],
    title: json["title"],
    description: json["description"],
    audioLink: json["audio_link"],
    isDeleted: json["is_deleted"],
    isMessagetone: json["is_messagetone"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "god_id": godId,
    "title": title,
    "description": description,
    "audio_link": audioLink,
    "is_deleted": isDeleted,
    "is_messagetone": isMessagetone,
  };
}
