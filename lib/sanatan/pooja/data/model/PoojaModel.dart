// To parse this JSON data, do
//
//     final poojaModel = poojaModelFromJson(jsonString);

import 'dart:convert';

PoojaModel poojaModelFromJson(String str) =>
    PoojaModel.fromJson(json.decode(str));

String poojaModelToJson(PoojaModel data) => json.encode(data.toJson());

class PoojaModel {
  bool? status;
  List<PoojaData>? data;
  String? msg;

  PoojaModel({
    this.status,
    this.data,
    this.msg,
  });

  factory PoojaModel.fromJson(Map<String, dynamic> json) => PoojaModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<PoojaData>.from(
                json["data"]!.map((x) => PoojaData.fromJson(x))),
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

class PoojaData {
  int? id;
  String? specialTag;
  String? title;
  String? description;
  String? thumbnail;
  String? date;
  String? offering;
  String? poojaLocations;
  DateTime? createdAt;
  String? stripThumbnail;
  String? displayAmount;
  String? aboutUs;
  String? socialProof;

  PoojaData(
      {this.id,
      this.specialTag,
      this.title,
      this.description,
      this.thumbnail,
      this.date,
      this.offering,
      this.poojaLocations,
      this.createdAt,
      this.stripThumbnail,
      this.displayAmount,
      this.aboutUs,
      this.socialProof});

  factory PoojaData.fromJson(Map<String, dynamic> json) => PoojaData(
        id: json["id"],
        specialTag: json["special_tag"],
        title: json["title"],
        description: json["description"],
        thumbnail: json["thumbnail"],
        date: json["date"],
        offering: json["offering"],
        poojaLocations: json["pooja_locations"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        stripThumbnail: json["strip_thumbnail"],
        displayAmount: json["display_amount"],
        aboutUs: json["about_us"],
        socialProof: json["social_proof"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "special_tag": specialTag,
        "title": title,
        "description": description,
        "thumbnail": thumbnail,
        "date": date,
        "offering": offering,
        "pooja_locations": poojaLocations,
        "created_at": createdAt?.toIso8601String(),
        "strip_thumbnail": stripThumbnail,
        "display_amount": displayAmount,
        "about_us": aboutUs,
        "social_proof": socialProof,
      };
}
