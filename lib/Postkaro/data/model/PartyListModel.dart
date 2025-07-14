// To parse this JSON data, do
//
//     final partyListModal = partyListModalFromJson(jsonString);

import 'dart:convert';

PartyListModal partyListModalFromJson(String str) => PartyListModal.fromJson(json.decode(str));

String partyListModalToJson(PartyListModal data) => json.encode(data.toJson());

class PartyListModal {
  bool status;
  List<PartyDatum> data;
  String msg;

  PartyListModal({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory PartyListModal.fromJson(Map<String, dynamic> json) => PartyListModal(
    status: json["status"],
    data: List<PartyDatum>.from(json["data"].map((x) => PartyDatum.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
    "msg": msg,
  };
}

class PartyDatum {
  int id;
  int partyId;
  String partyName;
  String partyLogo;
  bool isShow;
  int position;

  PartyDatum({
    required this.id,
    required this.partyId,
    required this.partyName,
    required this.partyLogo,
    required this.isShow,
    required this.position,
  });

  factory PartyDatum.fromJson(Map<String, dynamic> json) => PartyDatum(
    id: json["id"],
    partyId: json["party_id"],
    partyName: json["party_name"],
    partyLogo: json["party_logo"],
    isShow: json["is_show"],
    position: json["position"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "party_id": partyId,
    "party_name": partyName,
    "party_logo": partyLogo,
    "is_show": isShow,
    "position": position,
  };
}
