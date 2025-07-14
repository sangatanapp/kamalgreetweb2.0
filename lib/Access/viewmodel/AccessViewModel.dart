import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Access/data/model/DisputeDataModel.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../data/api/AccessApi.dart';

class AccessViewModel extends GetxController {
  RxString whichAppSelected = "postshare".obs;
  RxString whichTypeToggle = "resetaccess".obs;
  RxBool showDispute = false.obs;
  final api = AccessApi(apiCallBaseOption());

  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController subscriptionEndDate = TextEditingController();
  RxList<DisputeData> disputeDataList = <DisputeData>[].obs;

  Future resetUser() async {
    EasyLoading.showToast("Resetting User Data...", dismissOnTap: false);

    final res = await api.resetUser(
        "Bearer ${GreetStorage.getAuthToken()!}",
        {
          "mobile_number": textEditingController.text,
          "app_name": whichAppSelected.value
        },
        "hi");
    try {
      if (res.response.statusCode == 201) {
        EasyLoading.showSuccess("User reset successfully");
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
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

  Future enableSubscription() async {
    EasyLoading.showToast("Enabling User Subscription...", dismissOnTap: false);

    final res = await api.enableSubscription(
        "Bearer ${GreetStorage.getAuthToken()!}",
        {
          "mobile_number": textEditingController.text,
          "app_name": whichAppSelected.value,
          "payment_duedate": subscriptionEndDate.text
        },
        "hi");
    try {
      if (res.response.statusCode == 201) {
        EasyLoading.showSuccess("Enable subscription successfully !");
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
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

  Future getDisputeData() async {
    EasyLoading.show(dismissOnTap: false);

    final res = await api.getDisputeData(
        "Bearer ${GreetStorage.getAuthToken()!}",
        {
          "mobile_number": textEditingController.text,
          "app_name": whichAppSelected.value,
        },
        "hi");
    try {
      if (res.response.statusCode == 200) {
        DisputeDataModel model = DisputeDataModel.fromJson(res.data);
        disputeDataList.value = model.data ?? [];
        if (disputeDataList.value.isNotEmpty == true) {
          showDispute.value = true;
          showDispute.refresh();
          disputeDataList.refresh();
        } else {
          showDispute.value = false;
          showDispute.refresh();
          EasyLoading.showError("No record found");
        }

        EasyLoading.dismiss();
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
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

  void cleanAccessData() {
    textEditingController.clear();
    subscriptionEndDate.clear();
  }
}
