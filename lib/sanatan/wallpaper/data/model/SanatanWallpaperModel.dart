// To parse this JSON data, do
//
//     final sanatanWallpaperModel = sanatanWallpaperModelFromJson(jsonString);

import 'dart:convert';

SanatanWallpaperModel sanatanWallpaperModelFromJson(String str) =>
    SanatanWallpaperModel.fromJson(json.decode(str));

String sanatanWallpaperModelToJson(SanatanWallpaperModel data) =>
    json.encode(data.toJson());

class SanatanWallpaperModel {
  bool? status;
  List<SanatanWallpaperList>? data;
  String? msg;

  SanatanWallpaperModel({
    this.status,
    this.data,
    this.msg,
  });

  factory SanatanWallpaperModel.fromJson(Map<String, dynamic> json) =>
      SanatanWallpaperModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SanatanWallpaperList>.from(
                json["data"]!.map((x) => SanatanWallpaperList.fromJson(x))),
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

class SanatanWallpaperList {
  int? id;
  String? title;
  String? postUrl;
  String? createdAt;
  int? godId;
  String? wallpaperType;
  String? godName;
  int? homeScreen;
  int? lockScreen;
  int? bothScreen;

  SanatanWallpaperList({
    this.id,
    this.title,
    this.postUrl,
    this.createdAt,
    this.godId,
    this.wallpaperType,
    this.godName,
    this.homeScreen,
    this.lockScreen,
    this.bothScreen,
  });

  factory SanatanWallpaperList.fromJson(Map<String, dynamic> json) =>
      SanatanWallpaperList(
        id: json["id"],
        title: json["title"],
        postUrl: json["post_url"],
        createdAt: json["created_at"],
        godId: json["god_id"],
        wallpaperType: json["wallpaper_type"],
        godName: json["god_name"],
        homeScreen: json["home_screen"],
        lockScreen: json["lock_screen"],
        bothScreen: json["both_screen"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "post_url": postUrl,
        "created_at": createdAt,
        "god_id": godId,
        "wallpaper_type": wallpaperType,
        "god_name": godName,
        "home_screen": homeScreen,
        "lock_screen": lockScreen,
        "both_screen": bothScreen,
      };
}
