import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/sanatan/Wallpaper/data/api/WallpaperApi.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/data/model/SanatanWallpaperModel.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../../dashboard/view/DashboardScreen.dart';

class WallpaperViewModel extends GetxController {
  Rx<TextEditingController> wallpaperTitleCtrl = TextEditingController().obs;
  RxList<SanatanWallpaperList> sanatanWallpaperList =
      <SanatanWallpaperList>[].obs;

  final api = WallpaperApi(apiCallBaseOption());

  final rxSanatanWallpaperStatus = Status.INITIAL.obs;

  void setRxSanatanWallpaperStatus(Status value) =>
      rxSanatanWallpaperStatus.value = value;

  Future createWallpaper() async {
    EasyLoading.show();

    // if (sanatanDashboardCtrl.selectedCategoryList.contains('video')) {
    //   await creationVideoUploadCtrl
    //       .videoToFirebase(postController.videoPathForFirebase!);
    // }

    final res =
        await api.createWallpaper("Bearer ${GreetStorage.getAuthToken()!}", {
      "title": wallpaperTitleCtrl.value.text,
      "post_url": sanatanDashboardCtrl.selectedCategoryList.contains('video')
          ? imageVideoMainCtrl.videoFirebaseUrl.value
          : imageVideoMainCtrl.mainPostImage.value,
      "wallpaper_type": sanatanDashboardCtrl.selectedCategoryList.contains('video')
          ? "video"
          : "photo",
      "god_id": sanatanCreationCtrl
          .fetchGodIdFromName(sanatanCreationCtrl.godSelectorController.text)[0]
          .toString()
    });
    try {
      if (res.response.statusCode == 200 || res.response.statusCode == 201) {
        EasyLoading.showSuccess("Wallpaper Added");
        getWallpaper();
        Get.back();
      } else {
        EasyLoading.showError("Something Went Wrong");
      }
    } catch (e) {}
  }

  Future getWallpaper() async {
    setRxSanatanWallpaperStatus(Status.LOADING);
    final res =
        await api.getWallPaper("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        SanatanWallpaperModel model = SanatanWallpaperModel.fromJson(res.data);
        sanatanWallpaperList.value = model.data ?? [];
        sanatanWallpaperList.value = sanatanWallpaperList.reversed.toList();
        sanatanWallpaperList.refresh();
        setRxSanatanWallpaperStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxSanatanWallpaperStatus(Status.ERROR);
      }
    } catch (e) {
      setRxSanatanWallpaperStatus(Status.ERROR);
    }
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting wallpaper...");

    final res = await api.deleteSanatanWallpaper(
        "Bearer ${GreetStorage.getAuthToken()!}", id);
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getWallpaper();
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
