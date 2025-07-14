import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/data/api/DarshanApi.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/data/model/DarshanModel.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../apicalling/ApiCallBaseOption.dart';

class DarshanViewModel extends GetxController {
  Rx<TextEditingController> darshanTitleCtrl = TextEditingController().obs;
  Rx<TextEditingController> darshanDescCtrl = TextEditingController().obs;
  RxList<DarshanDataList> darshanList = <DarshanDataList>[].obs;
  RxBool isPremium = false.obs;

  final api = DarshanApi(apiCallBaseOption());

  final rxDarshanStatus = Status.INITIAL.obs;

  void setRxDarshanStatus(Status value) => rxDarshanStatus.value = value;

  Future createDarshan() async {
    EasyLoading.show();

    final res =
        await api.createDarshan("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": darshanTitleCtrl.value.text,
      "description": darshanDescCtrl.value.text,
      "god_url": imageVideoMainCtrl.mainPostImage.value,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString(),
      "is_premium": isPremium.value
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Darshan Added");
        getDarshan();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future getDarshan() async {
    setRxDarshanStatus(Status.LOADING);
    final res = await api.getDarshan("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        DarshanModel model = DarshanModel.fromJson(res.data);
        darshanList.value = model.data ?? [];
        darshanList.value = darshanList.reversed.toList();
        darshanList.refresh();
        setRxDarshanStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxDarshanStatus(Status.ERROR);
      }
    } catch (e) {
      setRxDarshanStatus(Status.ERROR);
    }
  }
  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Aarti...");

    final res = await api.deleteDarshan(
        "Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getDarshan();
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

}
