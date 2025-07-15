// To parse this JSON data, do
//
//     final dashModel = dashModelFromJson(jsonString);

import 'dart:convert';

DashModel dashModelFromJson(String str) => DashModel.fromJson(json.decode(str));

String dashModelToJson(DashModel data) => json.encode(data.toJson());

class DashModel {
  bool? status;
  List<PostDatum>? postData;
  String? msg;

  DashModel({
    this.status,
    this.postData,
    this.msg,
  });

  factory DashModel.fromJson(Map<String, dynamic> json) => DashModel(
        status: json["status"],
        postData: json["post_data"] == null
            ? []
            : List<PostDatum>.from(
                json["post_data"]!.map((x) => PostDatum.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "post_data": postData == null
            ? []
            : List<dynamic>.from(postData!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class PostDatum {
  int? id;
  String? title;
  String? sharingContent;
  String? postUrl;
  String? namePlate;
  String? background;
  dynamic avatarUrl;
  String? avatarPostion;
  String? avatarShape;
  String? startDate;
  String? endDate;
  String? createdAt;
  String? updatedAt;
  String? nameColor;
  PostType? postType;
  List<int>? tagList;
  List<String>? categoryList;
  bool? isSelectedForDeletion = false;
  bool? isPinned;
  int? sharedCount;
  int? downloadCount;

  PostDatum(
      {this.id,
      this.title,
      this.sharingContent,
      this.postUrl,
      this.namePlate,
      this.background,
      this.avatarUrl,
      this.avatarPostion,
      this.avatarShape,
      this.startDate,
      this.endDate,
      this.createdAt,
      this.updatedAt,
      this.nameColor,
      this.postType,
      this.tagList,
      this.categoryList,
      this.isSelectedForDeletion,
      this.isPinned,
      this.sharedCount,
      this.downloadCount});

  factory PostDatum.fromJson(Map<String, dynamic> json) => PostDatum(
        id: json["id"],
        title: json["title"],
        sharingContent: json["sharing_content"],
        postUrl: json["post_url"],
        namePlate: json["name_plate"],
        background: json["bg_url"],
        avatarUrl: json["avatar_url"],
        avatarPostion: json["avatar_postion"] ?? "",
        // Provide a default value if null
        nameColor: json["name_color_code"] ?? "0xFF000000",
        // Provide a default value if null
        avatarShape: json["avatar_shape"] ?? "",
        // Provide a default value if null
        startDate: json["start_date"],
        endDate: json["end_date"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        sharedCount: json["shared_count"],
        downloadCount: json["download_count"],
        isSelectedForDeletion: json['is_selected_for_deletion'],
        isPinned: json['is_pinned'],
        postType: postTypeValues.map[json["post_type"]] ?? PostType.IMAGE,
        // Provide a default value if null
        tagList: json["tag_list"] == null
            ? []
            : List<int>.from(json["tag_list"]!.map((x) => x)),
        categoryList: json["categoryList"] == null
            ? []
            : List<String>.from(json["categoryList"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "sharing_content": sharingContent,
        "post_url": postUrl,
        "post_url": namePlate,
        "background": background,
        "avatar_url": avatarUrl,
        "name_color_code": nameColor,
        "avatar_postion": avatarPostionValues.reverse[avatarPostion],
        "avatar_shape": avatarShapeValues.reverse[avatarShape],
        "start_date": startDate,
        "end_date": endDate,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "shared_count": sharedCount,
        "download_count": downloadCount,
        "is_selected_for_deletion": isSelectedForDeletion,
        "post_type": postTypeValues.reverse[postType],
        "tag_list":
            tagList == null ? [] : List<dynamic>.from(tagList!.map((x) => x)),
        "categoryList": categoryList == null
            ? []
            : List<dynamic>.from(categoryList!.map((x) => x)),
      };
}

enum AvatarPostion { BOTTOM_LEFT, BOTTOM_RIGHT, CENTER, TOP_LEFT, TOP_RIGHT }

final avatarPostionValues = EnumValues({
  "bottomLeft": AvatarPostion.BOTTOM_LEFT,
  "bottomRight": AvatarPostion.BOTTOM_RIGHT,
  "center": AvatarPostion.CENTER,
  "topLeft": AvatarPostion.TOP_LEFT,
  "topRight": AvatarPostion.TOP_RIGHT
});

enum AvatarShape { CIRCLE, SQUARE }

final avatarShapeValues =
    EnumValues({"circle": AvatarShape.CIRCLE, "square": AvatarShape.SQUARE});

enum PostType { IMAGE, VIDEO }

final postTypeValues =
    EnumValues({"image": PostType.IMAGE, "video": PostType.VIDEO});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
