import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Payment/data/api/PaymentApi.dart';
import 'package:kamal_greet_web_2/Payment/data/model/PaymentModel.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../login/view/LoginPage.dart';

class PaymentViewModel extends GetxController {
  final TextEditingController offerNameController = TextEditingController();
  final TextEditingController displayTextController = TextEditingController();
  final TextEditingController mrpController = TextEditingController();
  final TextEditingController payableController = TextEditingController();
  final TextEditingController offerDiscountController = TextEditingController();

  RxBool enablePayable = false.obs;
  RxInt groupValue = 0.obs;
  RxBool isCheckboxShow = false.obs;
  RxBool isSinglePayment = false.obs;
  RxString whichAppSelected = "postshare".obs;
  final api = PaymentApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  void calculateOfferPercentage() {
    int mrp = int.parse(mrpController.text);
    int sellingPrice = int.parse(payableController.text);

    double discount = (mrp - sellingPrice).toDouble();
    double discountPercentage = (discount / mrp) * 100;

    offerDiscountController.text =
        "${discountPercentage.floor().toString()}% off";
    update();
  }

  Future updatePayment() async {
    EasyLoading.showToast("Updating Data...", dismissOnTap: false);

    final res = await api.updatePayment(
        "Bearer ${GreetStorage.getAuthToken()!}",
        {
          "is_recurringpayment_byphonepe": groupValue.value == 1 ? true : false,
          "is_recurringpayment_byrazorpay": groupValue.value == 0 ? true : false
        },
        "hi");
    try {
      if (res.response.statusCode == 201) {
        EasyLoading.showSuccess("Payment method successfully updated!");
      } else if (res.response.statusCode == 401) {
        Get.offAll(const LoginPage());
        // loginCtr.phoneNumber.value.clear();
        GreetStorage.cleanAllLocalStorage();
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future getPayment() async {
    final res = await api.getPayment("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        PaymentModel model = PaymentModel.fromJson(res.data);
        model.data?.forEach((content) {
          if (content.isRecurringpaymentByphonepe == true) {
            groupValue.value = 1;
            groupValue.refresh();
          }
          if (content.isRecurringpaymentByrazorpay == true) {
            groupValue.value = 0;
            groupValue.refresh();
          }
        });
      } else if (res.response.statusCode == 401) {
        Get.offAll(const LoginPage());
        // loginCtr.phoneNumber.value.clear();
        GreetStorage.cleanAllLocalStorage();
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
