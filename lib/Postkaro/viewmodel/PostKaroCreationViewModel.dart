import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/data/api/PostkaroApi.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/PartyListModel.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/main.dart';

class PostKaroCreationViewModel extends GetxController {
  final api = PostkaroApi(apiCallBaseOption());

  final startDate = TextEditingController();
  final endDate = TextEditingController();
  final titleController = TextEditingController().obs;
  final sharingContent = TextEditingController().obs;

  ///---------*** Extras ***---------///
  RxBool isEdited = false.obs;
  RxBool isFrame = false.obs;
  RxBool isPolitical = false.obs;
  RxBool isWishes = false.obs;
  RxBool other = false.obs;
  RxBool isLoading = false.obs;
  RxString selectedAlignment = 'bottomLeft'.obs;
  RxString selectedShape = 'square'.obs;
  Uint8List? videoPathForFirebase;
  RxString mainPostImage = ''.obs;
  RxString videoFirebaseUrl = "".obs;

  void selectOption(String option) => selectedAlignment.value = option;

  void selectVideoAvtarShapeOption(String option) =>
      selectedShape.value = option;

  ///---------*** Wishes Alignment ***---------///
  RxString selectedWishesPosition = 'topLeft'.obs;

  void selectWishesPosition(String option) {
    selectedWishesPosition.value = option;
  }

  ///---------*** Notification ***---------///
  RxBool notifyUsers = false.obs;

  RxList<String> selectedPostKaroNotificationList =
      ["postshare", "postkaro", "sharepost", "politicalposter"].obs;

  List<String> postKaroNotificationList = [
    "postshare",
    "postkaro",
    "sharepost",
    "politicalposter"
  ];

  ///---------*** PARTY LIST ***---------///

  RxList partyIdList = [].obs;
  RxList selectedPartyNameList = [].obs;
  RxList<String> partyNameList = <String>[].obs;
  List<PartyDatum> partyList = [];
  final partyLogoStatus = Status.INITIAL.obs;

  void setPartyLogoStatus(Status value) => partyLogoStatus.value = value;

  Future callPartyListApi() async {
    setPartyLogoStatus(Status.LOADING);
    try {
      final res = await api.getWebPartyList(
          "Bearer ${GreetStorage.getAuthToken()!}", "hi");
      partyList = [];

      if (res.response.statusCode == 200) {
        PartyListModal model = PartyListModal.fromJson(res.data);
        partyList = model.data;
        partyNameList.value =
            partyList.map((party) => party.partyName).toList();
        partyNameList.insert(0, "Select All");
        partyList.insert(
            0,
            PartyDatum(
                id: 0,
                partyId: 0,
                partyName: "",
                partyLogo: "",
                isShow: true,
                position: 0));
        setPartyLogoStatus(Status.COMPLETED);
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
    } catch (e) {
      setPartyLogoStatus(Status.ERROR);

      if (kDebugMode) {
        print(e);
      }
    }
  }

  ///---------*** Creation ***---------///

  void checkFields() {
    if (startDate.text.isEmpty || endDate.text.isEmpty) {
      EasyLoading.showError('Select Start & End Date');
    }

    /// VALIDATING TITLE
    else if (titleController.value.text.isEmpty) {
      EasyLoading.showError('Please Add Title');
    }

    /// VALIDATING LANGUAGE
    else if (dashCtr.languageName.value == '' &&
        whichAppSelected.value != "quran") {
      EasyLoading.showError('Select Language');
    }

    /// VALIDATING CATEGORY
    else if (subCategoryCtrl.selectedCategoryList.value.isEmpty) {
      EasyLoading.showError('Please Select Category');
    }

    /// VALIDATING TAGS
    else if (subCategoryCtrl.fieldNameMapping.value.isEmpty) {
      EasyLoading.showError('Select Tags');
    }

    /// VALIDATING POST IMAGE
    else if (mainPostImage.value.toString().isEmpty) {
      EasyLoading.showError('Please Add Post Image');
    }

    /// VALIDATING PARTY
    else if ((subCategoryCtrl.fieldNameMapping.value.contains('political')) &&
        (selectedPartyNameList.value.isEmpty)) {
      EasyLoading.showError('Please Select Party');
    } else {
      if (subCategoryCtrl.fieldNameMapping.value.contains('political')) {
        isFrame.value = false;
        isWishes.value = false;
        isPolitical.value = true;
        other.value = false;
      } else if (subCategoryCtrl.fieldNameMapping.value.contains('wishes')) {
        isFrame.value = false;
        isWishes.value = true;
        isPolitical.value = false;
        other.value = false;
      } else if (subCategoryCtrl.fieldNameMapping.value.contains('frame')) {
        isFrame.value = true;
        isWishes.value = false;
        isPolitical.value = false;
        other.value = false;
      } else {
        isFrame.value = false;
        isWishes.value = false;
        isPolitical.value = false;
        other.value = true;
      }

      createPost();
    }
  }

  Future createPost() async {
    EasyLoading.showInfo('addingCard'.tr);
    List<String> categoryList = subCategoryCtrl.selectedCategoryList.toList();

    if (categoryList.contains('frame')) {
      isFrame.value = true;
    } else {
      isFrame.value = false;
    }
    String partyLogo = "";
    if (subCategoryCtrl.fieldNameMapping.value.contains('political')) {
      if (selectedPartyLogoOption.value.contains("noLogo")) {
        partyLogo = "";
      } else {
        partyLogo = selectedPartyLogoOption.value;
      }
    } else {
      partyLogo = "";
    }

    /// EXTRACTING TAG NAMES FOR HASHMAP BELOW ----------------------
    final reversedMap =
        subCategoryCtrl.tagHashMap.map((key, value) => MapEntry(value, key));

    final tagNames = subCategoryCtrl.idTag.value
        .map((id) => reversedMap[id.toString()])
        .where((name) => name != null)
        .toList();
    print(tagNames);

    /// EXTRACTING TAG NAMES FOR HASHMAP ABOVE ----------------------

    var data = {
      "title": titleController.value.text,
      "sharing_content": sharingContent.value.text,
      "avatar_postion": selectedAlignment.value,
      // "party_logo": finalPartyLogo.value,
      "party_logo": "",
      "partylogo_position": partyLogo,
      "notify": notifyUsers.value,
      "start_date": startDateString.value,
      "start_time": startTimeString.value,
      "end_date": endDateString.value,
      "end_time": endTimeString.value,
      "tag_list": subCategoryCtrl.idTag.value,
      "tagname_list": tagNames,
      "category_list": categoryList,
      "wishes_position": selectedWishesPosition.value,
      // "state_id": dashCtr.stateId.toString(),
      "state_id": "0",
      "post_language": dashCtr.languageShortName.value,
      "is_frame": isFrame.value,
      "is_wishes": isWishes.value,
      "is_political": isPolitical.value,
      "other": other.value,
      "party_id": partyIdList.value,
      "avatar_shape": subCategoryCtrl.selectedCategoryList.contains('video')
          ? selectedShape.value
          : "square",
      "name_plate":
          "https://firebasestorage.googleapis.com/v0/b/postkaro-3dd61.appspot.com/o/nameplat%2F771ff000-6a38-1f3b-9c89-13b8add6da5e?alt=media&token=7453f9d8-b84d-4601-9082-369b99a17f36",
      "bg_url": "",
      "name_color_code": "0xFF000000",
      "app_name": selectedPostKaroNotificationList
    };

    if (subCategoryCtrl.selectedCategoryList.contains('video')) {
      if (videoPathForFirebase != null) {
        await creationVideoUploadCtrl.videoToFirebase(videoPathForFirebase!);
        String thumbnailUrl = await creationVideoUploadCtrl
            .thumbnailToFirebase(mainPostImage.value);

        data['video_url'] = videoFirebaseUrl.value;
        // data['videoRatio'] = videoRatio.value;
        data['post_url'] = thumbnailUrl;
        data['post_type'] = "video";
      } else {
        EasyLoading.showError('Select Video First');
      }
    } else {
      data['post_type'] = "image";
      data['post_url'] = mainPostImage.value;
    }

    print('DATA=> ${data}');
    final res = subCategoryCtrl.selectedCategoryList.contains('video')
        ? await api.createVideoCard("Bearer ${GreetStorage.getAuthToken()!}",
            data, dashCtr.languageShortName.value)
        : await api.createPost("Bearer ${GreetStorage.getAuthToken()!}", data,
            dashCtr.languageShortName.value);

    if (res.response.statusCode == 200 || res.response.statusCode == 201) {
      EasyLoading.showSuccess("cardAddedSuccessfully".tr);
      dashCtr.selectedApp.value == 3
          ? dashCtr.getCard('hi', forFilter: false, from: 'quran')
          : dashCtr.getCard('hi', forFilter: false);
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
    } else if (res.response.statusCode == 401) {
      handleApiStatus(401);
    } else {
      EasyLoading.showError(
          "${res.response.statusCode} ${res.response.statusMessage}");
    }
  }
}
