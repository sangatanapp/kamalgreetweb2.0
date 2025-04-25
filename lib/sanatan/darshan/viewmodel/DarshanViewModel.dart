import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/data/api/DarshanApi.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/data/model/DarshanModel.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DarshanViewModel extends GetxController {
  Rx<TextEditingController> darshanTitleCtrl = TextEditingController().obs;
  Rx<TextEditingController> darshanDescCtrl = TextEditingController().obs;
  RxList<DarshanDataList> darshanList = <DarshanDataList>[].obs;

  final api = DarshanApi(apiCallBaseOption());

  final rxDarshanStatus = Status.INITIAL.obs;

  void setRxDarshanStatus(Status value) => rxDarshanStatus.value = value;

  Future createDarshan() async {
    EasyLoading.show();

    final res =
        await api.createDarshan("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": darshanTitleCtrl.value.text,
      "description": darshanDescCtrl.value.text,
      "god_url": postController.mainPostImage.value,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
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
}
