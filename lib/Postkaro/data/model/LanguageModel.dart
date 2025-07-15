// To parse this JSON data, do
//
//     final languageModel = languageModelFromJson(jsonString);

import 'dart:convert';

LanguageModel languageModelFromJson(String str) => LanguageModel.fromJson(json.decode(str));

String languageModelToJson(LanguageModel data) => json.encode(data.toJson());

class LanguageModel {
  bool status;
  List<LanguageList> data;
  String msg;

  LanguageModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) => LanguageModel(
    status: json["status"],
    data: List<LanguageList>.from(json["data"].map((x) => LanguageList.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class LanguageList {
  int id;
  String language;
  String languageCode;
  bool isShow;
  int position;

  LanguageList({
    required this.id,
    required this.language,
    required this.languageCode,
    required this.isShow,
    required this.position,
  });

  factory LanguageList.fromJson(Map<String, dynamic> json) => LanguageList(
    id: json["id"],
    language: json["language"],
    languageCode: json["language_code"],
    isShow: json["is_show"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "language": language,
    "language_code": languageCode,
    "is_show": isShow,
    "position": position,
  };
}
