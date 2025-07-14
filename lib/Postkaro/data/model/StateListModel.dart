// To parse this JSON data, do
//
//     final stateModel = stateModelFromJson(jsonString);

import 'dart:convert';

StateModel stateModelFromJson(String str) => StateModel.fromJson(json.decode(str));

String stateModelToJson(StateModel data) => json.encode(data.toJson());

class StateModel {
  bool status;
  List<StateList> data;
  String msg;

  StateModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory StateModel.fromJson(Map<String, dynamic> json) => StateModel(
    status: json["status"],
    data: List<StateList>.from(json["data"].map((x) => StateList.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class StateList {
  int id;
  String state;
  int stateId;
  int position;

  StateList({
    required this.id,
    required this.state,
    required this.stateId,
    required this.position,
  });

  factory StateList.fromJson(Map<String, dynamic> json) => StateList(
    id: json["id"],
    state: json["state"],
    stateId: json["state_id"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "state": state,
    "state_id": stateId,
    "position": position,
  };
}
