// To parse this JSON data, do
//
//     final getIosUserDataModel = getIosUserDataModelFromJson(jsonString);

import 'dart:convert';

GetIosUserDataModel getIosUserDataModelFromJson(String str) =>
    GetIosUserDataModel.fromJson(json.decode(str));

String getIosUserDataModelToJson(GetIosUserDataModel data) =>
    json.encode(data.toJson());

class GetIosUserDataModel {
  bool? status;
  List<IosUserDataList>? data;
  String? msg;

  GetIosUserDataModel({
    this.status,
    this.data,
    this.msg,
  });

  factory GetIosUserDataModel.fromJson(Map<String, dynamic> json) =>
      GetIosUserDataModel(
        status: json["status"],
        data: json["data"] == null
            ? []
            : List<IosUserDataList>.from(
                json["data"]!.map((x) => IosUserDataList.fromJson(x))),
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

class IosUserDataList {
  int? id;
  String? mobileNumber;
  String? name;
  String? subscriptionType;
  bool? isIos;
  String? createdAt;

  IosUserDataList({
    this.id,
    this.mobileNumber,
    this.name,
    this.subscriptionType,
    this.isIos,
    this.createdAt,
  });

  factory IosUserDataList.fromJson(Map<String, dynamic> json) =>
      IosUserDataList(
          id: json["id"],
          mobileNumber: json["mobile_number"],
          name: json["name"],
          subscriptionType: json["subscription_type"],
          isIos: json["is_ios"],
          createdAt: json["created_at"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "mobile_number": mobileNumber,
        "name": name,
        "subscription_type": subscriptionType,
        "is_ios": isIos,
        "created_at": createdAt
      };
}
