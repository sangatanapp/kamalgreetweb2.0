import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/guruvani/data/api/GuruvaniApi.dart';
import 'package:kamal_greet_web_2/guruvani/data/model/GuruvaniModel.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:retrofit/retrofit.dart';
import '../../Utils/database/GreetStorage.dart';

class GuruvaniViewModel extends GetxController {
  final api = GuruvaniApi(apiCallBaseOption());
  RxList<GuruvaniPostData> guruvaniPostList = <GuruvaniPostData>[].obs;
  final rxRequestStatus = Status.INITIAL.obs;
  RxBool notifyUsers = false.obs;

  void setRxRequestStatus(Status value) => rxRequestStatus.value = value;

  /// TEXT EDITING CONTROLLER VARIABLES ----------------------------------------
  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final titleController = TextEditingController().obs;
  final colorController = TextEditingController().obs;
  final sharingContent = TextEditingController().obs;

  Future getGuruvaniCards() async {
    setRxRequestStatus(Status.LOADING);
    HttpResponse<dynamic> res;
    try {
      res = await api.getGuruvaniCardList(
          "Bearer ${GreetStorage.getAuthToken()!}", "hi");
      if (res.response.statusCode == 200) {
        GuruvaniModel model = GuruvaniModel.fromJson(res.data);
        model.postData?.forEach((element) {
          element.isSelectedForDeletion = false;
        });
        guruvaniPostList.value = model.postData ?? [];
        setRxRequestStatus(Status.COMPLETED);
        // dashCtr.tagCtr.getTagList('all');
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        setRxRequestStatus(Status.ERROR);

        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {
      setRxRequestStatus(Status.ERROR);
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future createGuruPost() async {
    EasyLoading.showInfo('addingCard'.tr);

    final res = await api.createGuruPost(
        "Bearer ${GreetStorage.getAuthToken()!}",
        {
          "title": titleController.value.text,
          "sharing_content": sharingContent.value.text,
          // "avatar_postion": selectedAlignment.value,
          // "party_logo": finalPartyLogo.value,
          "party_logo": "",
          "partylogo_position": "",
          "notify": notifyUsers.value,
          // "start_date": startDateString.value,
          // "start_time": postController.startTimeString.value,
          // "end_date": postController.endDateString.value,
          // "end_time": postController.endTimeString.value,
          "tag_list": [],
          "category_list": [],
          // "wishes_position": postController.selectedWishesPosition.value,
          // "state_id": dashCtr.stateId.toString(),
          "state_id": "0",
          "post_language": "hi",
          "is_frame": false,
          "is_wishes": false,
          "is_political": false,
          "other": true,
          "party_id": [0],
          "avatar_shape": "square",
          "post_type": "image",
          // "post_url": postController.mainPostImage.value,
          "guruid_list": fetchGuruIdsFromNames(guruCtrl.selectedGuruName.value),
          "name_plate":
              "https://firebasestorage.googleapis.com/v0/b/postkaro-3dd61.appspot.com/o/nameplat%2F771ff000-6a38-1f3b-9c89-13b8add6da5e?alt=media&token=7453f9d8-b84d-4601-9082-369b99a17f36",
          "bg_url": "",
          "name_color_code": "0xFF000000",
          "app_name": [],
          "language": "",
          "country_id": "",
        },
        "hi");

    if (res.response.statusCode == 200 || res.response.statusCode == 201) {
      getGuruvaniCards();
    } else if (res.response.statusCode == 401) {
      handleApiStatus(401);
    } else {
      EasyLoading.showError(
          "${res.response.statusCode} ${res.response.statusMessage}");
    }
  }

  Future deleteCard(int id) async {
    EasyLoading.showToast("Deleting Card...");

    final res = await api.deleteCard(
        "Bearer ${GreetStorage.getAuthToken()!}", id, "hi");
    try {
      if (res.response.statusCode == 200) {
        refresh();
        EasyLoading.showSuccess("Card Deleted Successfully!");
        await getGuruvaniCards();
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

  void checkFields() {
    if (startDate.value.text.isEmpty || endDate.value.text.isEmpty) {
      EasyLoading.showError('Select Start & End Date');
    } else if (titleController.value.text.isEmpty) {
      EasyLoading.showError('Please Add Title');
      // } else if (languageName.value.isEmpty) {
      //   EasyLoading.showError('Select Language');
    } else if (guruCtrl.selectedGuruName.value.isEmpty) {
      EasyLoading.showError('Select Guru');
      // } else if (mainPostImage.value
      //     .toString()
      //     .isEmpty) {
      //   EasyLoading.showError('Please Add Post Image');
    } else {
      createGuruPost();
    }
  }

  List fetchGuruIdsFromNames(List<String> nameList) {
    List<int?> guruIds = guruCtrl.guruList.value
        .where((guru) => nameList.contains(guru.guruName))
        .map((guru) => guru.guruId)
        .toList();
    return guruIds;
  }
}
