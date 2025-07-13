// To parse this JSON data, do
//
//     final poojaBookingListModel = poojaBookingListModelFromJson(jsonString);

import 'dart:convert';

PoojaBookingListModel poojaBookingListModelFromJson(String str) =>
    PoojaBookingListModel.fromJson(json.decode(str));

String poojaBookingListModelToJson(PoojaBookingListModel data) =>
    json.encode(data.toJson());

class PoojaBookingListModel {
  bool status;
  List<PoojaBookingListData> data;
  String msg;

  PoojaBookingListModel({
    required this.status,
    required this.data,
    required this.msg,
  });

  factory PoojaBookingListModel.fromJson(Map<String, dynamic> json) =>
      PoojaBookingListModel(
        status: json["status"],
        data: List<PoojaBookingListData>.from(
            json["data"].map((x) => PoojaBookingListData.fromJson(x))),
        msg: json["msg"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "msg": msg,
      };
}

class PoojaBookingListData {
  int id;
  int poojaId;
  String name;
  String mobileNumber;
  String title;
  String poojaDate;
  DateTime createdAt;
  String amount;
  String paymentStatus;
  String subscriptionId;
  DateTime paymentDate;
  String subscriptionType;
  String yajamanaName;
  String gotra;
  String thumbnailUrl;
  String planId;

  PoojaBookingListData({
    required this.id,
    required this.poojaId,
    required this.name,
    required this.mobileNumber,
    required this.title,
    required this.poojaDate,
    required this.createdAt,
    required this.amount,
    required this.paymentStatus,
    required this.subscriptionId,
    required this.paymentDate,
    required this.subscriptionType,
    required this.yajamanaName,
    required this.gotra,
    required this.thumbnailUrl,
    required this.planId,
  });

  factory PoojaBookingListData.fromJson(Map<String, dynamic> json) =>
      PoojaBookingListData(
        id: json["id"],
        poojaId: json["pooja_id"],
        name: json["name"],
        mobileNumber: json["mobile_number"],
        title: json["title"],
        poojaDate: json["pooja_date"],
        createdAt: DateTime.parse(json["created_at"]),
        amount: json["amount"],
        paymentStatus: json["payment_status"],
        subscriptionId: json["subscription_id"],
        paymentDate: DateTime.parse(json["payment_date"]),
        subscriptionType: json["subscription_type"],
        yajamanaName: json["yajamana_name"],
        gotra: json["gotra"],
        thumbnailUrl: json["thumbnail_url"],
        planId: json["plan_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pooja_id": poojaId,
        "name": name,
        "mobile_number": mobileNumber,
        "title": title,
        "pooja_date": poojaDate,
        "created_at": createdAt.toIso8601String(),
        "amount": amount,
        "payment_status": paymentStatus,
        "subscription_id": subscriptionId,
        "payment_date": paymentDate.toIso8601String(),
        "subscription_type": subscriptionType,
        "yajamana_name": yajamanaName,
        "gotra": gotra,
        "thumbnail_url": thumbnailUrl,
        "plan_id": planId,
      };
}
