import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/data/api/StotraApi.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/data/model/StotraModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../Utils/database/GreetStorage.dart';
import '../../../../Utils/widgets/DynamicAppbar.dart';
import '../../../../apicalling/ApiCallBaseOption.dart';

class StotraViewModel extends GetxController {
  Rx<TextEditingController> stotraTitleTextCtrl = TextEditingController().obs;
  Rx<TextEditingController> stotraDescTextCtrl = TextEditingController().obs;
  final api = StotraApi(apiCallBaseOption());

  final rxStotraStatus = Status.INITIAL.obs;
  RxList<StotraListData> stotraList = <StotraListData>[].obs;

  void setRxStotraStatus(Status value) => rxStotraStatus.value = value;

  Future getStotra() async {
    setRxStotraStatus(Status.LOADING);
    final res = await api.getStotra("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        StotraModel model = StotraModel.fromJson(res.data);
        stotraList.value = model.data ?? [];
        stotraList.value = stotraList.reversed.toList();
        stotraList.refresh();
        setRxStotraStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxStotraStatus(Status.ERROR);
      }
    } catch (e) {
      setRxStotraStatus(Status.ERROR);
    }
  }

  Future createStotra() async {
    EasyLoading.show(dismissOnTap: false);

    final res =
        await api.createStotra("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": stotraTitleTextCtrl.value.text,
      "description_title": stotraDescTextCtrl.value.text,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Stotra Added");
        // getMantra();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Stotra...");

    final res =
        await api.deleteStotra("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getStotra();
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
