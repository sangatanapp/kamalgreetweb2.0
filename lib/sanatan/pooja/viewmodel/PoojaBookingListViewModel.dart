import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/api/PoojaApi.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/PoojaBookingList.dart';

class PoojaBookingListViewModel extends GetxController {
  // ############################## GET API ######################################
  // ############################## GET API ######################################

  final api = PoojaApi(apiCallBaseOption());
  RxList<PoojaBookingListData> poojaBookingListData =
      <PoojaBookingListData>[].obs;

  Future getPoojaBookingList() async {
    EasyLoading.show(dismissOnTap: false);
    final res = await api.getPoojaBookingList(
        "Bearer ${GreetStorage.getAuthToken()!}", "hi");
    try {
      if (res.response.statusCode == 200) {
        PoojaBookingListModel model = PoojaBookingListModel.fromJson(res.data);
        poojaBookingListData.value = model.data ?? [];
        poojaBookingListData.refresh();
        EasyLoading.showSuccess(model.msg ?? "");
      } else {
        EasyLoading.showError("Something went wrong!");
      }
    } catch (e) {
      EasyLoading.showError("Something went wrong!");
    }
  }
}
