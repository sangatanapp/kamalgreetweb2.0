// To parse this JSON data, do
//
//     final poojaPricingModel = poojaPricingModelFromJson(jsonString);

import 'dart:convert';

PoojaPricingModel poojaPricingModelFromJson(String str) =>
    PoojaPricingModel.fromJson(json.decode(str));

String poojaPricingModelToJson(PoojaPricingModel data) =>
    json.encode(data.toJson());

class PoojaPricingModel {
  bool? status;
  List<PoojaPricingData>? data;
  String? msg;

  PoojaPricingModel({this.status, this.data, this.msg});

  factory PoojaPricingModel.fromJson(Map<String, dynamic> json) =>
      PoojaPricingModel(
          status: json["status"],
          data: json["data"] == null
              ? []
              : List<PoojaPricingData>.from(
                  json["data"]!.map((x) => PoojaPricingData.fromJson(x))),
          msg: json["msg"]);

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "msg": msg
      };
}

class PoojaPricingData {
  String? displayAmount;
  String? planId;

  PoojaPricingData({this.displayAmount, this.planId});

  factory PoojaPricingData.fromJson(Map<String, dynamic> json) =>
      PoojaPricingData(
          displayAmount: json["display_amount"], planId: json["plan_id"]);

  Map<String, dynamic> toJson() =>
      {"display_amount": displayAmount, "plan_id": planId};
}
