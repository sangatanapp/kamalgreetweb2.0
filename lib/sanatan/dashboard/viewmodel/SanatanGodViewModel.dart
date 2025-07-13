import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/api/SanatanGodApi.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/data/model/SanatanGodListModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

import '../../../Utils/widgets/DynamicAppbar.dart';
import '../view/SanatanCreationScreen.dart';

class SanatanGodViewModel extends GetxController {
  final api = SanatanGodApi(Dio(BaseOptions(
    contentType: 'application/json',
    validateStatus: ((status) => true),
    receiveTimeout: const Duration(seconds: 30),
  ))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  RxBool isLoadingGodImage = false.obs;
  RxString godPhoto = ''.obs;

  TextEditingController godNameController = TextEditingController();
  TextEditingController? godSloganController = TextEditingController();
  int? godId;

  RxList<SanatanGodDetail> sanatanGodList = <SanatanGodDetail>[].obs;
  RxBool isEditGod = false.obs;

  Future getGodList() async {
    sanatanCreationCtrl.allGuruSuggestions.clear();
    try {
      final res =
          await api.getGodList("Bearer ${GreetStorage.getAuthToken()!}");
      if (res.response.statusCode == 200) {
        SanatanGodListModel model = SanatanGodListModel.fromJson(res.data);
        sanatanGodList.value = model.data ?? [];
        for (int i = 0; i < sanatanGodList.length; i++) {
          sanatanCreationCtrl.allGuruSuggestions
              .add(sanatanGodList[i].title ?? "");
        }
        sanatanGodList.refresh();
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {}
  }

  Future createUpdateGod() async {
    EasyLoading.show();
    try {
      HttpResponse<dynamic> res;
      if (isEditGod.value == true) {
        res = await api.createGod("Bearer ${GreetStorage.getAuthToken()!}", {
          "title": godNameController.text,
          "description": godSloganController?.text ?? "",
          "thumbnail": godPhoto.value,
          "god_id": godId
        });
      } else {
        res = await api.createGod("Bearer ${GreetStorage.getAuthToken()!}", {
          "title": godNameController.text,
          "description": godSloganController?.text ?? "",
          "thumbnail": godPhoto.value
        });
      }
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("God Created Successfully");
        getGodList();
        Get.back();
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {}
  }

  void clearAddGod() {
    godNameController.clear();
    godSloganController?.clear();
    godPhoto.value = "";
    godPhoto.refresh();
    isEditGod.value = false;
    isEditGod.refresh();
  }

  void uploadGodPhoto(String photo) {
    godPhoto.value = photo;
    update();
    isLoadingGodImage.value = false;
  }

  void removeGodhoto() {
    godPhoto.value = '';
    update();
  }
}
