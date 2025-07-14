import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/api/PoojaApi.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/PoojaModel.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/PoojaPricingModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../apicalling/ApiCallBaseOption.dart';

class PoojaDashboardViewModel extends GetxController {
  TextEditingController poojaTitleController = TextEditingController();
  TextEditingController poojaDescController = TextEditingController();
  TextEditingController poojaSummaryLineController = TextEditingController();
  TextEditingController poojaOfferingDoneController = TextEditingController();
  TextEditingController poojaDevoteeCountController = TextEditingController();
  TextEditingController singlePaymentController = TextEditingController();
  TextEditingController singlePaymentDisplayController =
      TextEditingController();
  TextEditingController discountTagController = TextEditingController();
  TextEditingController mrpController = TextEditingController();
  RxString poojaThumbnail = ''.obs;
  RxBool isLoadingPoojaThumbnail = false.obs;
  RxInt selectedPaymentType = 0.obs;

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
      "payment_id": selectedPricingTabIndex.value == -1
          ? "0  "
          : poojaPricingData[selectedPricingTabIndex.value].planId,
      "display_amount": selectedPricingTabIndex.value == -1
          ? "0"
          : poojaPricingData[selectedPricingTabIndex.value].displayAmount,
      "summary_line": poojaSummaryLineController.text,
      "offering": poojaOfferingDoneController.text,
      "devotee": poojaDevoteeCountController.text,
      "is_singlepayment": selectedPaymentType.value == 0 ? true : false,
      "single_payment_amount": singlePaymentController.text.isEmpty
          ? 0
          : (int.parse(singlePaymentController.text) * 100),
      "single_dispaly_paymentamount": singlePaymentDisplayController.text,
      "discount_tag": discountTagController.text,
      "mrp": mrpController.text
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

  bool validateFields() {
    if (poojaTitleController.text.isEmpty) {
      EasyLoading.showError('Enter pooja title');
      return false;
    } else if (poojaDescController.text.isEmpty) {
      EasyLoading.showError('Enter pooja description');
      return false;
    } else if (poojaSummaryLineController.text.isEmpty) {
      EasyLoading.showError('Enter Summary Line');
      return false;
    } else if (poojaOfferingDoneController.text.isEmpty) {
      EasyLoading.showError('Enter Offering Done');
      return false;
    } else if (poojaDevoteeCountController.text.isEmpty) {
      EasyLoading.showError('Enter Devotee Count');
      return false;
    } else if (selectedPaymentType.value == 1 &&
        selectedPricingTabIndex.value == -1) {
      EasyLoading.showError('Select Pricing');
      return false;
    } else if (selectedPaymentType.value == 0) {
      if (singlePaymentController.text.isEmpty) {
        EasyLoading.showError('Enter payment amount');
        return false;
      } else if (discountTagController.text.isEmpty) {
        EasyLoading.showError('Enter discount tag');
        return false;
      } else if (mrpController.text.isEmpty) {
        EasyLoading.showError('Enter MRP amount');
        return false;
      }
    }

    if (poojaThumbnail.value.isEmpty) {
      EasyLoading.showError('Select thumbnail');
      return false;
    }

    return true;
  }
}
