// To parse this JSON data, do
//
//     final guruListModel = guruListModelFromJson(jsonString);

import 'dart:convert';

GuruListModel guruListModelFromJson(String str) =>
    GuruListModel.fromJson(json.decode(str));

String guruListModelToJson(GuruListModel data) => json.encode(data.toJson());

class GuruListModel {
  bool? status;
  List<GuruDatum>? data;
  String? msg;

  GuruListModel({
    this.status,
    this.data,
    this.msg,
  });

  factory GuruListModel.fromJson(Map<String, dynamic> json) =>
      GuruListModel(
        status: json["status"],
        data: json["data"] == null ? [] : List<GuruDatum>.from(
            json["data"]!.map((x) => GuruDatum.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() =>
      {
        "status": status,
        "data": data == null ? [] : List<dynamic>.from(
            data!.map((x) => x.toJson())),
        "msg": msg,
      };
}

class GuruDatum {
  int? guruId;
  String? guruName;
  String? guruSlogan;
  String? guruLogo;
  bool? isVisible;
  DateTime? createdAt;
  int? position;

  GuruDatum({
    this.guruId,
    this.guruName,
    this.guruSlogan,
    this.guruLogo,
    this.isVisible,
    this.createdAt,
    this.position,
  });

  factory GuruDatum.fromJson(Map<String, dynamic> json) =>
      GuruDatum(
        guruId: json["guru_id"],
        guruName: json["guru_name"],
        guruSlogan: json["guru_slogan"],
        guruLogo: json["guru_logo"],
        isVisible: json["is_visible"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(
            json["created_at"]),
        position: json["position"],
      );

  Map<String, dynamic> toJson() =>
      {
        "guru_id": guruId,
        "guru_name": guruName,
        "guru_slogan": guruSlogan,
        "guru_logo": guruLogo,
        "is_visible": isVisible,
        "created_at": createdAt?.toIso8601String(),
        "position": position,
      };
}
