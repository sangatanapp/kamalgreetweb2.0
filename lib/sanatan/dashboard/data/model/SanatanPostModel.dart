// To parse this JSON data, do
//
//     final sanatanPostModel = sanatanPostModelFromJson(jsonString);

import 'dart:convert';

SanatanPostModel sanatanPostModelFromJson(String str) =>
    SanatanPostModel.fromJson(json.decode(str));

String sanatanPostModelToJson(SanatanPostModel data) =>
    json.encode(data.toJson());

class SanatanPostModel {
  bool? status;
  List<SanatanPostData>? data;
  String? msg;

  SanatanPostModel({
    this.status,
    this.data,
    this.msg,
  });

  factory SanatanPostModel.fromJson(Map<String, dynamic> json) =>
      SanatanPostModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<SanatanPostData>.from(
                json["data"]!.map((x) => SanatanPostData.fromJson(x))),
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

class SanatanPostData {
  int? id;
  String? title;
  String? sharingContent;
  String? postUrl;
  String? avatarPosition;
  String? postType;
  bool? isDeleted;
  int? sharedCount;
  int? downloadCount;
  bool? isPinned;
  bool? isFrame;
  String? language;
  String? startDate;
  String? endDate;
  dynamic tagList;
  String? createdAt;
  int? godId;

  SanatanPostData({
    this.id,
    this.title,
    this.sharingContent,
    this.postUrl,
    this.avatarPosition,
    this.postType,
    this.isDeleted,
    this.sharedCount,
    this.downloadCount,
    this.isPinned,
    this.isFrame,
    this.language,
    this.startDate,
    this.endDate,
    this.tagList,
    this.createdAt,
    this.godId,
  });

  factory SanatanPostData.fromJson(Map<String, dynamic> json) =>
      SanatanPostData(
        id: json["id"],
        title: json["title"],
        sharingContent: json["sharing_content"],
        postUrl: json["post_url"],
        avatarPosition: json["avatar_position"],
        postType: json["post_type"],
        isDeleted: json["is_deleted"],
        sharedCount: json["shared_count"],
        downloadCount: json["download_count"],
        isPinned: json["is_pinned"],
        isFrame: json["is_frame"],
        language: json["language"],
        startDate: json["start_date"],
        endDate: json["end_date"],
        tagList: json["tag_list"],
        createdAt: json["created_at"],
        godId: json["god_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sharing_content": sharingContent,
        "post_url": postUrl,
        "avatar_position": avatarPosition,
        "post_type": postType,
        "is_deleted": isDeleted,
        "shared_count": sharedCount,
        "download_count": downloadCount,
        "is_pinned": isPinned,
        "is_frame": isFrame,
        "language": language,
        "start_date": startDate,
        "end_date": endDate,
        "tag_list": tagList,
        "created_at": createdAt,
        "god_id": godId,
      };
}
