// To parse this JSON data, do
//
//     final partyModel = partyModelFromJson(jsonString);

import 'dart:convert';

PartyModel partyModelFromJson(String str) => PartyModel.fromJson(json.decode(str));

String partyModelToJson(PartyModel data) => json.encode(data.toJson());

class PartyModel {
  bool? status;
  List<Datum>? data;
  String? msg;

  PartyModel({
    this.status,
    this.data,
    this.msg,
  });

  factory PartyModel.fromJson(Map<String, dynamic> json) => PartyModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class Datum {
  int? id;
  String? partName;
  String? partyLogo;
  List<String>? partyMemberlist;
  int? partyPosition;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.partName,
    this.partyLogo,
    this.partyMemberlist,
    this.partyPosition,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    partName: json["part_name"],
    partyLogo: json["party_logo"],
    partyMemberlist: json["party_memberlist"] == null ? [] : List<String>.from(json["party_memberlist"]!.map((x) => x)),
    partyPosition: json["party_position"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "part_name": partName,
    "party_logo": partyLogo,
    "party_memberlist": partyMemberlist == null ? [] : List<dynamic>.from(partyMemberlist!.map((x) => x)),
    "party_position": partyPosition,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
