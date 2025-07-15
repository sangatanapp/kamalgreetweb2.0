import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/main.dart';

void handleApiStatus(int statusCode) {
  switch (statusCode) {
    case 401:
      EasyLoading.showError("Session timeout or Token expired");
      Get.offAll(const LoginPage());
      loginController.phoneNumber.value.clear();
      GreetStorage.cleanAllLocalStorage();
      break;

    default:
      EasyLoading.showError("Something went wrong");
  }
}
