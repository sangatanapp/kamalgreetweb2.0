// To parse this JSON data, do
//
//     final stateByPartyIdModel = stateByPartyIdModelFromJson(jsonString);

import 'dart:convert';

StateByPartyIdModel stateByPartyIdModelFromJson(String str) => StateByPartyIdModel.fromJson(json.decode(str));

String stateByPartyIdModelToJson(StateByPartyIdModel data) => json.encode(data.toJson());

class StateByPartyIdModel {
  bool status;
  List<StateByPartyIdDatum> data;
  String msg;

  StateByPartyIdModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory StateByPartyIdModel.fromJson(Map<String, dynamic> json) => StateByPartyIdModel(
    status: json["status"],
    data: List<StateByPartyIdDatum>.from(json["data"].map((x) => StateByPartyIdDatum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class StateByPartyIdDatum {
  int id;
  int stateId;
  String partylogo;
  List<String> partyMemberlist;
  String stateName;

  StateByPartyIdDatum({
    required this.id,
    required this.stateId,
    required this.partylogo,
    required this.partyMemberlist,
    required this.stateName,
  });

  factory StateByPartyIdDatum.fromJson(Map<String, dynamic> json) => StateByPartyIdDatum(
    id: json["id"],
    stateId: json["stateId"],
    partylogo: json["partylogo"],
    partyMemberlist: List<String>.from(json["partyMemberlist"].map((x) => x)),
    stateName: json["stateName"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "stateId": stateId,
    "partylogo": partylogo,
    "partyMemberlist": List<dynamic>.from(partyMemberlist.map((x) => x)),
    "stateName": stateName,
  };
}
