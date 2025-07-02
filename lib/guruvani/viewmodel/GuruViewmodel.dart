import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/guruvani/data/api/GuruvaniApi.dart';
import 'package:kamal_greet_web_2/guruvani/data/model/GuruListModel.dart';
import 'package:kamal_greet_web_2/guruvani/data/model/GuruvaniModel.dart';
import 'package:retrofit/retrofit.dart';
import '../../Utils/database/GreetStorage.dart';

class GuruViewModel extends GetxController {
  final api = GuruvaniApi(apiCallBaseOption());
  List<String> allGuruSuggestions = [];
  RxList<String> selectedGuruName = <String>[].obs;
  RxBool isLoadingGuruImage = false.obs;
  RxString guruPhoto = ''.obs;
  TextEditingController guruNameController = TextEditingController();
  TextEditingController? guruSloganController = TextEditingController();
  int? guruId;
  RxList<GuruDatum> guruList = <GuruDatum>[].obs;
  RxBool isEditGuru = false.obs;
  final rxRequestStatus = Status.INITIAL.obs;
  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;
  Future getGuruList() async {
    allGuruSuggestions.clear();
    try {
      final res =
          await api.getGuruList("Bearer ${GreetStorage.getAuthToken()!}");
      if (res.response.statusCode == 200) {
        GuruListModel model = GuruListModel.fromJson(res.data);
        guruList.value = model.data ?? [];
        for (int i = 0; i < guruList.length; i++) {
          allGuruSuggestions.add(guruList[i].guruName ?? "");
        }
        guruList.refresh();
      } else if (res.response.statusCode == 401) {
        // Get.offAll(const LoginPage());
        // loginCtr.phoneNumber.value.clear();
        GreetStorage.cleanAllLocalStorage();
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {}
  }

  Future createUpdateGuru() async {
    EasyLoading.show();
    try {
      HttpResponse<dynamic> res;
      if (isEditGuru.value == true) {
        res = await api.updateGuru("Bearer ${GreetStorage.getAuthToken()!}", {
          "guru_name": guruNameController.text,
          "guru_slogan": guruSloganController?.text ?? "",
          "guru_logo": guruPhoto.value,
          "guru_id": guruId
        });
      } else {
        res = await api.createGuru("Bearer ${GreetStorage.getAuthToken()!}", {
          "guru_name": guruNameController.text,
          "guru_slogan": guruSloganController?.text ?? "",
          "guru_logo": guruPhoto.value
        });
      }
      if (res.response.statusCode == 200) {
        EasyLoading.showSuccess("Guru Created Successfully");
        getGuruList();
        Get.back();
      } else if (res.response.statusCode == 401) {
        // Get.offAll(const LoginPage());
        // loginCtr.phoneNumber.value.clear();
        // GreetStorage.cleanAllLocalStorage();
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {}
  }

  Future deleteGuru() async {
    try {
      final res = await api.deleteGuru(
          "Bearer ${GreetStorage.getAuthToken()!}", guruId!);
      if (res.response.statusCode == 200) {
        EasyLoading.showSuccess("Guru Deleted Successfully");
        getGuruList();
        Get.back();
      } else if (res.response.statusCode == 401) {
        // Get.offAll(const LoginPage());
        // loginCtr.phoneNumber.value.clear();
        // GreetStorage.cleanAllLocalStorage();
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {}
  }

  void clearAddGuru() {
    guruNameController.clear();
    guruSloganController?.clear();
    guruPhoto.value = "";
    guruPhoto.refresh();
    isEditGuru.value = false;
    isEditGuru.refresh();
  }

  void uploadGuruPhoto(String photo) {
    guruPhoto.value = photo;
    update();
    isLoadingGuruImage.value = false;
  }

  void removeGuruPhoto() {
    guruPhoto.value = '';
    update();
  }

  void addGuru(String name) {
    selectedGuruName.add(name);
    selectedGuruName.refresh();
  }
}
