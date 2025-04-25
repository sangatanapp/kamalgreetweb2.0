import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/api/PoojaApi.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/PoojaModel.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/PoojaPricingModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class PoojaDashboardViewModel extends GetxController {
  TextEditingController poojaTitleController = TextEditingController();
  TextEditingController poojaDescController = TextEditingController();
  TextEditingController poojaSummaryLineController = TextEditingController();
  TextEditingController poojaOfferingDoneController = TextEditingController();
  TextEditingController poojaDevoteeCountController = TextEditingController();
  RxString poojaThumbnail = ''.obs;
  RxBool isLoadingPoojaThumbnail = false.obs;

  void clearAddPooja() {
    selectedPricingTabIndex.value = -1;
    selectedPricingTabIndex.refresh();
    poojaTitleController.clear();
    poojaOfferingDoneController.clear();
    poojaSummaryLineController.clear();
    poojaDevoteeCountController.clear();
    poojaDescController.clear();
    poojaThumbnail.value = "";
    poojaThumbnail.refresh();
  }

  void uploadPoojaThumbnail(String photo) {
    poojaThumbnail.value = photo;
    update();
    isLoadingPoojaThumbnail.value = false;
  }

  void removePoojaThumbnail() {
    poojaThumbnail.value = '';
    update();
  }

  // ############################## Create API ######################################
  // ############################## Create API ######################################

  Future createPooja() async {
    EasyLoading.show(dismissOnTap: false);
    final res =
        await api.createPooja("Bearer ${GreetStorage.getAuthToken()!}", "hi", {
      "title": poojaTitleController.text,
      "description": poojaDescController.text,
      "strip_thumbnail": poojaThumbnail.value,
      "payment_id": poojaPricingData[selectedPricingTabIndex.value].planId,
      "display_amount":
          poojaPricingData[selectedPricingTabIndex.value].displayAmount,
      "summary_line": poojaSummaryLineController.text,
      "offering": poojaOfferingDoneController.text,
      "devotee": poojaDevoteeCountController.text,
    });
    try {
      if (res.response.statusCode == 201) {
        Get.back();
        getPooja();
        EasyLoading.showSuccess(res.response.data["msg"]);
      } else {
        EasyLoading.showError(
            "Something Went Wrong\nStatus Code - ${res.response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
  }

  // ############################## GET API ######################################
  // ############################## GET API ######################################

  final api = PoojaApi(apiCallBaseOption());
  RxList<PoojaData> poojaData = <PoojaData>[].obs;
  RxList<PoojaPricingData> poojaPricingData = <PoojaPricingData>[].obs;
  RxInt selectedPricingTabIndex = (-1).obs;

  Future getPooja() async {
    EasyLoading.show(dismissOnTap: false);
    final res =
        await api.getPooja("Bearer ${GreetStorage.getAuthToken()!}", "hi");
    try {
      if (res.response.statusCode == 200) {
        PoojaModel model = PoojaModel.fromJson(res.data);
        poojaData.value = model.data ?? [];
        poojaData.refresh();
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError(
            "Something Went Wrong\nStatus Code - ${res.response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
  }

  Future getPoojaPricingDetails() async {
    final res = await api.getPoojaPricing(
        "Bearer ${GreetStorage.getAuthToken()!}", "hi");
    try {
      if (res.response.statusCode == 200) {
        PoojaPricingModel model = PoojaPricingModel.fromJson(res.data);
        poojaPricingData.value = model.data ?? [];
        poojaPricingData.refresh();
      } else {}
    } catch (e) {}
  }

  // ############################## Delete API ######################################
  // ############################## Delete API ######################################

  Future deletePooja({required int id}) async {
    EasyLoading.show(dismissOnTap: false);
    final res =
        await api.deletePooja("Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        EasyLoading.showSuccess(res.response.data["msg"]);
        getPooja();
      } else {
        EasyLoading.showError(
            "Something Went Wrong\nStatus Code - ${res.response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
  }
}
