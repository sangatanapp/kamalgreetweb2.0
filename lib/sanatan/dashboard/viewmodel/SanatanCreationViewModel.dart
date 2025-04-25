import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import '../data/api/SanatanApi.dart';

class SanatanCreationViewModel extends GetxController {
  final api = SanatanApi(apiCallBaseOption());

  TextEditingController godSelectorController = TextEditingController();

  List<String> allGuruSuggestions = [];
  List<String> allPostTypeSuggestions = ["photo", "video"];

  void checkFields() {
    if (postController.startDateString.value.isEmpty ||
        postController.endDateString.value.isEmpty) {
      EasyLoading.showError('Select Start & End Date');
    }

    /// VALIDATING TITLE
    else if (postController.titleController.value.text.isEmpty) {
      EasyLoading.showError('Please Add Title');
    }

    /// VALIDATING POST IMAGE
    else if (postController.mainPostImage.value.toString().isEmpty) {
      EasyLoading.showError('Please Add Post Image');
    } else {
      createSanatanPost();
    }
  }

  Future createSanatanPost() async {
    EasyLoading.showInfo('addingCard'.tr);
    if (tagController.selectedCategoryList.contains('video')) {
      await creationVideoUploadCtrl
          .videoToFirebase(postController.videoPathForFirebase!);
    }

    final res =
        await api.createSanatanPost("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": postController.titleController.value.text,
      "sharing_content": postController.sharingContent.value.text,
      "avatar_postion": postController.selectedAlignment.value,
      "start_date": postController.startDateString.value,
      "end_date": postController.endDateString.value,
      "post_url": tagController.selectedCategoryList.contains('video')
          ? postController.videoFirebaseUrl.value
          : postController.mainPostImage.value,
      "post_type": tagController.selectedCategoryList.contains('video')
          ? "video"
          : "photo",
      "god_id": fetchGodIdFromName(godSelectorController.text)[0].toString()
    });
    if (res.response.statusCode == 200 || res.response.statusCode == 201) {
      EasyLoading.showSuccess("cardAddedSuccessfully".tr);
      sanatanDashboardCtrl.getSanatanPost();
      Get.back();
    } else if (res.response.statusCode == 401) {
      Get.offAll(const LoginPage());
      loginCtr.phoneNumber.value.clear();
      GreetStorage.cleanAllLocalStorage();
    } else {
      EasyLoading.showError(
          "${res.response.statusCode} ${res.response.statusMessage}");
    }
  }

  List fetchGodIdFromName(String name) {
    // Step 2: Filter the guruList based on names
    List<int?> godId = sanatanGodCtrl.sanatanGodList.value
        .where((god) => name.contains(god.title!))
        .map((god) => god.id)
        .toList();
    return godId;
  }
}
