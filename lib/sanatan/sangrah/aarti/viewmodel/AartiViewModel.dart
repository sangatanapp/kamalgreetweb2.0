import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/data/api/AartiApi.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/data/model/AartiModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class AartiViewModel extends GetxController {
  Rx<TextEditingController> aartiTitleTextCtrl = TextEditingController().obs;
  Rx<TextEditingController> aartiDescTextCtrl = TextEditingController().obs;
  final api = AartiApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));
  final rxAartiStatus = Status.INITIAL.obs;
  RxList<AartiDataList> aartiList = <AartiDataList>[].obs;

  void setRxAartiStatus(Status value) => rxAartiStatus.value = value;

  Future getAarti() async {
    setRxAartiStatus(Status.LOADING);
    final res = await api.getAarti("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        AartiModel model = AartiModel.fromJson(res.data);
        aartiList.value = model.data ?? [];
        aartiList.value = aartiList.reversed.toList();
        aartiList.refresh();
        setRxAartiStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxAartiStatus(Status.ERROR);
      }
    } catch (e) {
      setRxAartiStatus(Status.ERROR);
    }
  }

  Future createAarti() async {
    EasyLoading.show(dismissOnTap: false);

    final res =
        await api.createAarti("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": aartiTitleTextCtrl.value.text,
      "description_title": aartiDescTextCtrl.value.text,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Aarti Added");
        // getMantra();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }


  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Aarti...");

    final res =
    await api.deleteAarti("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getAarti();
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
