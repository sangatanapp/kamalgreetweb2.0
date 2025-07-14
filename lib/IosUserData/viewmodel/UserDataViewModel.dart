import 'package:dio/dio.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/IosUserData/data/api/UserDataApi.dart';
import 'package:kamal_greet_web_2/IosUserData/data/model/GetIosUserDataModel.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';

class UserDataViewModel extends GetxController {
  final api = UserDataApi(apiCallBaseOption());

  RxList<IosUserDataList> iosUserDataList = <IosUserDataList>[].obs;
  final rxUserDataStatus = Status.INITIAL.obs;

  void setRxUserDataStatus(Status value) => rxUserDataStatus.value = value;

  Future getIosUserData() async {
    setRxUserDataStatus(Status.LOADING);
    final res =
        await api.getIosUserData("Bearer ${GreetStorage.getAuthToken()!}");
    try {
      if (res.response.statusCode == 200) {
        GetIosUserDataModel model = GetIosUserDataModel.fromJson(res.data);
        iosUserDataList.value = model.data ?? [];
        // iosUserDataList.value.addAll(model.data ?? []);
        iosUserDataList.refresh();
        setRxUserDataStatus(Status.COMPLETED);
      } else {
        EasyLoading.showError("Something Went Wrong");
        setRxUserDataStatus(Status.ERROR);
      }
    } catch (e) {
      setRxUserDataStatus(Status.ERROR);
    }
  }
}
