import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/data/api/ChaleesaApi.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/data/model/ChaleesaModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../../Utils/database/GreetStorage.dart';
import '../../../../Utils/widgets/DynamicAppbar.dart';

class ChaleesaViewModel extends GetxController {
  Rx<TextEditingController> chaleesaTitleTextCtrl = TextEditingController().obs;
  Rx<TextEditingController> chaleesaDescTextCtrl = TextEditingController().obs;
  final api = ChaleesaApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  final rxChaleesaStatus = Status.INITIAL.obs;
  RxList<ChaleesaListData> chaleesaList = <ChaleesaListData>[].obs;

  void setRxChaleesaStatus(Status value) => rxChaleesaStatus.value = value;

  Future getChallesa() async {
    setRxChaleesaStatus(Status.LOADING);
    final res = await api.getChaleesa("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        ChaleesaModel model = ChaleesaModel.fromJson(res.data);
        chaleesaList.value = model.data ?? [];
        chaleesaList.value = chaleesaList.reversed.toList();
        chaleesaList.refresh();
        setRxChaleesaStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxChaleesaStatus(Status.ERROR);
      }
    } catch (e) {
      setRxChaleesaStatus(Status.ERROR);
    }
  }

  Future createChaleesa() async {
    EasyLoading.show(dismissOnTap: false);

    final res =
        await api.createChaleesa("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": chaleesaTitleTextCtrl.value.text,
      "description_title": chaleesaDescTextCtrl.value.text,
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Chaleesa Added");
        // getMantra();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Chaleesa...");

    final res =
        await api.deleteChaleesa("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getChallesa();
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
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
