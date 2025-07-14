// To parse this JSON data, do
//
//     final disputeDataModel = disputeDataModelFromJson(jsonString);

import 'dart:convert';

DisputeDataModel disputeDataModelFromJson(String str) => DisputeDataModel.fromJson(json.decode(str));

String disputeDataModelToJson(DisputeDataModel data) => json.encode(data.toJson());

class DisputeDataModel {
  bool? status;
  List<DisputeData>? data;
  String? msg;

  DisputeDataModel({
    this.status,
    this.data,
    this.msg,
  });

  factory DisputeDataModel.fromJson(Map<String, dynamic> json) => DisputeDataModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<DisputeData>.from(json["data"]!.map((x) => DisputeData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class DisputeData {
  String? name;
  String? mobileNumber;
  String? subscriptionType;
  String? subscriptionId;
  String? createdAt;

  DisputeData({
    this.name,
    this.mobileNumber,
    this.subscriptionType,
    this.subscriptionId,
    this.createdAt,
  });

  factory DisputeData.fromJson(Map<String, dynamic> json) => DisputeData(
    name: json["name"],
    mobileNumber: json["mobile_number"],
    subscriptionType: json["subscription_type"],
    subscriptionId: json["subscription_id"],
    createdAt: json["created_at"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "mobile_number": mobileNumber,
    "subscription_type": subscriptionType,
    "subscription_id": subscriptionId,
    "created_at": createdAt,
  };
}
