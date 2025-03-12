import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import '../../Utils/database/GreetStorage.dart';
import '../../apicalling/ApiCallBaseOption.dart';
import '../data/api/AuthApi.dart';
import '../data/model/LoginModel.dart';

class LoginViewModel extends GetxController {
  final api = AuthApi(apiCallBaseOption());

  final phoneNumber = TextEditingController().obs;
  final otp = TextEditingController().obs;
  final rxRequestStatus = Status.INITIAL.obs;
  RxStatus status = RxStatus.success();
  LoginModel? model;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  RxBool isLoading = false.obs;
  RxBool isError = false.obs;

  Future loginUser({required String mobileNumber}) async {
    isLoading.value = true;
    try {
      final res = await api.sendOtp({"mobile_number": mobileNumber});
      model = LoginModel.fromJson(res.data);
      await GreetStorage.setUserIdentificationToken(
          model!.identificationToken ?? "");
      if (res.response.statusCode == 200) {
        otp.value.text = '';
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
    }
  }

  Future submitOTP({required BuildContext context}) async {
    isLoading.value = true;
    try {
      String token = GreetStorage.getUserIdentificationToken() ?? '';

      final res = await api.verifyOtp({
        "mobile_number": phoneNumber.value.text,
        "identification_token": token,
        "otp": int.parse(otp.value.text)
      });
      if (res.response.statusCode == 200) {
        isError.value = false;

        await GreetStorage.setAuthToken(res.data["auth_token"] ?? "");
        if (res.data['is_admin'] == null || res.data['is_admin'] != null) {
          bool adminCheck;
          if (res.data['is_admin'] == null) {
            adminCheck = false;
          } else {
            adminCheck = res.data['is_admin'];
          }
          if (!adminCheck) {
            isLoading.value = false;
            EasyLoading.showError(
                'You Do Not Have Dashboard Access. Please Contact the Admin.');
            return;
          } else {
            if (model!.otp.toString() == otp.value.text) {
              Future.delayed(Duration.zero)
                  .then((value) => context.go('/dashboard'));
            }
          }
        }
        if (kDebugMode) {
          print(res.response.data);
        }
        GetStorage().write('isAuthenticated', true);
      } else {
        isError.value = true;
      }

      isLoading.value = false;
    } catch (e) {
      isError.value = true;
      if (kDebugMode) {
        print(e);
      }
      isLoading.value = false;
    }
  }
}
