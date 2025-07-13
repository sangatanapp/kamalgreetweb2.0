// To parse this JSON data, do
//
//     final getPoojaDetailsModel = getPoojaDetailsModelFromJson(jsonString);

import 'dart:convert';

GetPoojaDetailsModel getPoojaDetailsModelFromJson(String str) =>
    GetPoojaDetailsModel.fromJson(json.decode(str));

String getPoojaDetailsModelToJson(GetPoojaDetailsModel data) =>
    json.encode(data.toJson());

class GetPoojaDetailsModel {
  bool? status;
  String? msg;
  List<GetPoojaDetailsData>? data;

  GetPoojaDetailsModel({
    this.status,
    this.msg,
    this.data,
  });

  factory GetPoojaDetailsModel.fromJson(Map<String, dynamic> json) =>
      GetPoojaDetailsModel(
        status: json["status"],
        msg: json["msg"],
        data: json["data"] == null
            ? []
            : List<GetPoojaDetailsData>.from(
                json["data"]!.map((x) => GetPoojaDetailsData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "msg": msg,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class GetPoojaDetailsData {
  int? id;
  int? poojaId;
  String? title;
  String? description;
  String? iconUrl;
  String? featureTitle;
  String? featureDescription;

  GetPoojaDetailsData(
      {this.id,
      this.poojaId,
      this.title,
      this.description,
      this.iconUrl,
      this.featureTitle,
      this.featureDescription});

  factory GetPoojaDetailsData.fromJson(Map<String, dynamic> json) =>
      GetPoojaDetailsData(
          id: json["id"],
          poojaId: json["pooja_id"],
          title: json["title"],
          description: json["description"],
          iconUrl: json["icon_url"],
          featureTitle: json["feature_title"],
          featureDescription: json["feature_description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "pooja_id": poojaId,
        "title": title,
        "description": description,
        "icon_url": iconUrl,
        "feature_title": featureTitle,
        "feature_description": featureDescription
      };
}
