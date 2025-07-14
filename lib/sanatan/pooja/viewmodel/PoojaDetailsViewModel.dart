import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/api/AddDetailsApi.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/data/model/GetPoojaDetailsModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../apicalling/ApiCallBaseOption.dart';
import '../view/PoojaDashboard.dart';

class PoojaDetailsViewModel extends GetxController {
  List poojaDetailsTab = ["Benefits", "Benefits"];
  TextEditingController poojaDetailsTitleController = TextEditingController();
  TextEditingController poojaDetailsDescController = TextEditingController();
  TextEditingController poojaDetailsOfferingController =
      TextEditingController();
  TextEditingController poojaDetailsSpecialOccasionController =
      TextEditingController();
  TextEditingController poojaDetailsAboutUsController = TextEditingController();
  TextEditingController poojaDetailsSocialProofController =
      TextEditingController();
  RxInt selectedTabIndex = 0.obs;

  final api = AddDetailsApi(apiCallBaseOption());

  String getRemainingUrl({required String whichTab}) {
    const map = {
      "process": "createPoojaProcessSteps",
      "benefits": "createPoojaBenefit",
      "package": "createPoojaPackageFeatures",
      "keyHighlights": "udatePujaDetails"
    };
    return map[whichTab] ?? "";
  }

  getRemainingBody({required String whichTab, required int poojaId}) {
    final map = {
      "process": {
        "pooja_id": poojaId,
        "title": poojaDetailsTitleController.text,
        "description": poojaDetailsDescController.text,
        "icon_url": poojaDashboardCtrl.poojaThumbnail.value
      },
      "benefits": {
        "pooja_id": poojaId,
        "title": poojaDetailsTitleController.text,
        "icon_url": poojaDashboardCtrl.poojaThumbnail.value
      },
      "package": {
        "pooja_id": poojaId,
        "feature_title": poojaDetailsTitleController.text,
        "feature_description": poojaDetailsDescController.text
      },
      "keyHighlights": {
        "id": poojaId,
        "date": poojaDetailsTitleController.text,
        "pooja_locations": poojaDetailsDescController.text,
        "offering": poojaDetailsOfferingController.text,
        "special_tag": poojaDetailsSpecialOccasionController.text,
        "about_us": poojaDetailsAboutUsController.text,
        "social_proof": poojaDetailsSocialProofController.text
      }
    };
    return map[whichTab];
  }

  Future updatePoojaDetails(
      {required String whichTab, required int poojaId}) async {
    EasyLoading.show(dismissOnTap: false);
    final res = await api.updatePoojaDetails(
        getRemainingUrl(whichTab: whichTab),
        "Bearer ${GreetStorage.getAuthToken()!}",
        "hi",
        getRemainingBody(whichTab: whichTab, poojaId: poojaId));
    try {
      if (res.response.statusCode == 201) {
        Get.back();

        whichTab != "keyHighlights"
            ? getPoojaDetails(poojaId: poojaId, whichTab: whichTab)
            : poojaDashboardCtrl.getPooja();
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

  RxList<GetPoojaDetailsData> poojaDetailsData = <GetPoojaDetailsData>[].obs;

  String getRemainingPath({required String whichTab}) {
    const map = {
      "process": "getPoojaProcessSteps",
      "benefits": "getPoojaBenefit",
      "package": "getPoojaPackageFeature"
    };
    return map[whichTab] ?? "";
  }

  Future getPoojaDetails(
      {required String whichTab, required int poojaId}) async {
    EasyLoading.show(dismissOnTap: false);
    final res = await api.getPoojaDetails(getRemainingPath(whichTab: whichTab),
        poojaId, "Bearer ${GreetStorage.getAuthToken()!}", "hi");
    try {
      if (res.response.statusCode == 200) {
        GetPoojaDetailsModel model = GetPoojaDetailsModel.fromJson(res.data);
        poojaDetailsData.value = model.data ?? [];
        poojaDetailsData.refresh();
        EasyLoading.dismiss();
      } else {
        EasyLoading.showError(
            "Something Went Wrong\nStatus Code - ${res.response.statusCode}");
      }
    } catch (e) {
      EasyLoading.showError("Something Went Wrong");
    }
  }

  void clearData() {
    selectedTabIndex.value = 0;
    selectedTabIndex.refresh();
    poojaDetailsData.clear();
    clearController();
  }

  void clearController() {
    poojaDetailsTitleController.clear();
    poojaDetailsDescController.clear();
    poojaDetailsOfferingController.clear();
    poojaDetailsSpecialOccasionController.clear();
    poojaDetailsAboutUsController.clear();
    poojaDetailsSocialProofController.clear();
  }
}
