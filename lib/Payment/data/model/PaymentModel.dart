// To parse this JSON data, do
//
//     final paymentModel = paymentModelFromJson(jsonString);

import 'dart:convert';

PaymentModel paymentModelFromJson(String str) => PaymentModel.fromJson(json.decode(str));

String paymentModelToJson(PaymentModel data) => json.encode(data.toJson());

class PaymentModel {
  bool? status;
  List<Datum>? data;
  String? msg;

  PaymentModel({
    this.status,
    this.data,
    this.msg,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) => PaymentModel(
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
  bool? isRecurringpaymentByphonepe;
  bool? isRecurringpaymentByrazorpay;

  Datum({
    this.isRecurringpaymentByphonepe,
    this.isRecurringpaymentByrazorpay,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    isRecurringpaymentByphonepe: json["is_recurringpayment_byphonepe"],
    isRecurringpaymentByrazorpay: json["is_recurringpayment_byrazorpay"],
  );

  Map<String, dynamic> toJson() => {
    "is_recurringpayment_byphonepe": isRecurringpaymentByphonepe,
    "is_recurringpayment_byrazorpay": isRecurringpaymentByrazorpay,
  };
}
