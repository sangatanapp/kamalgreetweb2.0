import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import '../../../apicalling/StatusCodeResponse.dart';
import '../data/api/SanatanApi.dart';

class SanatanCreationViewModel extends GetxController {
  final api = SanatanApi(Dio(BaseOptions(
      contentType: 'application/json', validateStatus: ((status) => true)))
    ..interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90)));

  /// TEXT EDITING CONTROLLER VARIABLES ----------------------------------------
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final titleController = TextEditingController().obs;
  final colorController = TextEditingController().obs;
  final sharingContent = TextEditingController().obs;
  TextEditingController godSelectorController = TextEditingController();

  List<String> allGuruSuggestions = [];
  List<String> allPostTypeSuggestions = ["photo", "video"];

  void checkFields() {
    if (postController.startDateString.value.isEmpty ||
        postController.endDateString.value.isEmpty) {
      EasyLoading.showError('Select Start & End Date');
    }

    /// VALIDATING TITLE
    else if (titleController.value.text.isEmpty) {
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
    if (sanatanDashboardCtrl.selectedCategoryList.contains('video')) {
      await creationVideoUploadCtrl
          .videoToFirebase(postController.videoPathForFirebase!);
    }

    final res =
        await api.createSanatanPost("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": titleController.value.text,
      "sharing_content": sharingContent.value.text,
      "avatar_postion": postController.selectedAlignment.value,
      "start_date": startDate.value,
      "end_date": endDate.value,
      "post_url": sanatanDashboardCtrl.selectedCategoryList.contains('video')
          ? postController.videoFirebaseUrl.value
          : postController.mainPostImage.value,
      "post_type": sanatanDashboardCtrl.selectedCategoryList.contains('video')
          ? "video"
          : "photo",
      "god_id": fetchGodIdFromName(godSelectorController.text)[0].toString()
    });
    if (res.response.statusCode == 200 || res.response.statusCode == 201) {
      EasyLoading.showSuccess("cardAddedSuccessfully".tr);
      sanatanDashboardCtrl.getSanatanPost();
      Get.back();
    } else if (res.response.statusCode == 401) {
      handleApiStatus(401);
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
