// To parse this JSON data, do
//
//     final poojaBookingList = poojaBookingListFromJson(jsonString);

import 'dart:convert';

PoojaBookingListModel poojaBookingListModelFromJson(String str) => PoojaBookingListModel.fromJson(json.decode(str));

String poojaBookingListModelToJson(PoojaBookingListModel data) => json.encode(data.toJson());

class PoojaBookingListModel {
  bool? status;
  List<PoojaBookingListData>? data;
  String? msg;

  PoojaBookingListModel({
    this.status,
    this.data,
    this.msg,
  });

  factory PoojaBookingListModel.fromJson(Map<String, dynamic> json) => PoojaBookingListModel(
    status: json["status"],
    data: json["data"] == null ? [] : List<PoojaBookingListData>.from(json["data"]!.map((x) => PoojaBookingListData.fromJson(x))),
    msg: json["msg"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "msg": msg,
  };
}

class PoojaBookingListData {
  int? id;
  int? poojaId;
  String? name;
  String? mobileNumber;
  String? title;
  String? poojaDate;
  DateTime? createdAt;
  String? amount;
  String? paymentStatus;
  String? subscriptionId;
  DateTime? paymentDate;
  String? subscriptionType;

  PoojaBookingListData({
    this.id,
    this.poojaId,
    this.name,
    this.mobileNumber,
    this.title,
    this.poojaDate,
    this.createdAt,
    this.amount,
    this.paymentStatus,
    this.subscriptionId,
    this.paymentDate,
    this.subscriptionType,
  });

  factory PoojaBookingListData.fromJson(Map<String, dynamic> json) => PoojaBookingListData(
    id: json["id"],
    poojaId: json["pooja_id"],
    name: json["name"],
    mobileNumber: json["mobile_number"],
    title: json["title"],
    poojaDate: json["pooja_date"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    amount: json["amount"],
    paymentStatus: json["payment_status"],
    subscriptionId: json["subscription_id"],
    paymentDate: json["payment_date"] == null ? null : DateTime.parse(json["payment_date"]),
    subscriptionType: json["subscription_type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "pooja_id": poojaId,
    "name": name,
    "mobile_number": mobileNumber,
    "title": title,
    "pooja_date": poojaDate,
    "created_at": createdAt?.toIso8601String(),
    "amount": amount,
    "payment_status": paymentStatus,
    "subscription_id": subscriptionId,
    "payment_date": paymentDate?.toIso8601String(),
    "subscription_type": subscriptionType,
  };
}
