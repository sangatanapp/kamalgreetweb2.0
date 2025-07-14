import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/data/api/PostkaroApi.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/PartyListModel.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/StateByPartyIdModel.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/StateListModel.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/main.dart';
import 'package:uuid/uuid.dart';

import '../data/model/PartyModel.dart';

class PostKaroDashboardViewModel extends GetxController {
  final api = PostkaroApi(apiCallBaseOption());

  /// ONGOING AND UPCOMING FILTER
  RxString filterType = "ONGOING".obs;

  toggleOngoingFilter(String val) {
    filterType.value = val;
  }

  RxInt parentPartyId = 0.obs;
  RxBool isStateLoading = false.obs;
  RxInt stateId = 0.obs;
  RxString stateName = "".obs;
  String partyListSelectedLanguage = "";
  RxInt partyListIdForUpdation = 0.obs;
  RxString logoPhoto = ''.obs;
  RxString partyName = "".obs;
  RxInt partyId = 0.obs;
  RxList<String> partyMember = <String>[].obs;
  RxString partyLogo = "0".obs;
  List<Datum?>? partyLists = [];
  RxList<String> partyNameList = <String>[].obs;
  RxString parentPartyName = "".obs;
  List<PartyDatum> partyList = [];

  /// STATE LIST API
  List<StateList> stateList = [];
  RxList<String> stateNamesList = <String>[].obs;
  RxList<String> selectedStateList = <String>[].obs;
  Map<String, String> stateIdHashMap = {};
  RxList<String> stateIdArray = <String>[].obs;
  RxBool isLoadingMore = false.obs;

  RxString firebaseImageUrl = "".obs;

  void clearParty() {
    stateName.value = '';
    stateId.value = 0;
    partyName.value = '';
    partyId.value = 0;
    logoPhoto.value = '';
    partyListIdForUpdation.value = 0;
    partyMember.value = []!;
    partyMember.refresh();
  }

  void reorderPartyMembers(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final movedItem = partyMember.removeAt(oldIndex);
    partyMember.insert(newIndex, movedItem);
  }

  Future createParty() async {
    EasyLoading.showInfo('Adding Party...');
    String finalLogo = '';

    /// Commented on 19th sept as per requirement
    if (logoPhoto.value == '' || logoPhoto.value.isEmpty) {
      finalLogo = partyLogo.value;
    } else {
      finalLogo = logoPhoto.value;
    }
    var data = {
      "part_name": partyName.value,
      "party_logo": finalLogo,
      "party_memberlist": partyMember.value,
      "state_id": stateId.value,
      "state": stateName.value,
      "party_id": partyId.value
    };
    try {
      final res = await api.createParty(
          "Bearer ${GreetStorage.getAuthToken()!}",
          data,
          partyListSelectedLanguage);
      if (res.response.statusCode == 200) {
        EasyLoading.showSuccess('Party Added Successfully!');
        getStateByPartyId(parentPartyId.value);
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError("${res.response.data["msg"]}");
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
    }
  }

  Future updateParty() async {
    EasyLoading.showInfo('Updating Party...');
    String finalLogo = '';

    if (logoPhoto.value == '' || logoPhoto.value.isEmpty) {
      finalLogo = partyLogo.value;
    } else {
      finalLogo = logoPhoto.value;
    }
    var data = {
      "part_name": partyName.value,
      "party_logo": finalLogo,
      "party_memberlist": partyMember.value,
      "state_id": stateId.value,
      "state": stateName.value,
      "party_id": partyId.value,
      "id": partyListIdForUpdation.value,
    };

    final res = await api.updatePartyList(
        "Bearer ${GreetStorage.getAuthToken()!}",
        data,
        partyListSelectedLanguage);
    if (res.response.statusCode == 200) {
      EasyLoading.showSuccess('Party Updated Successfully!');
      getStateByPartyId(parentPartyId.value);
      Navigator.pop(NavigationService.navigatorKey.currentContext!);
    } else if (res.response.statusCode == 401) {
      handleApiStatus(401);
    } else {
      EasyLoading.showError(
          "${res.response.statusCode} ${res.response.statusMessage}");
    }
  }

  /// GET STATE BY PARTY ID
  List<StateByPartyIdDatum> stateByPartyIdList = [];

  void setStateByPartyStatus(Status value) => stateByPartyStatus.value = value;
  RxBool isStateByPartyLoading = false.obs;
  final stateByPartyStatus = Status.INITIAL.obs;
  RxList<String> stateByPartyIdNameList = <String>[].obs;

  Future getStateByPartyId(int partyId) async {
    setStateByPartyStatus(Status.LOADING);
    try {
      final res = await api.getStateByParty(
          "Bearer ${GreetStorage.getAuthToken()!}", "hi", partyId);
      stateByPartyIdList = [];

      if (res.response.statusCode == 200) {
        StateByPartyIdModel model = StateByPartyIdModel.fromJson(res.data);
        stateByPartyIdList = model.data;
        stateByPartyIdNameList.value =
            stateByPartyIdList.map((state) => state.stateName).toList();
        setStateByPartyStatus(Status.COMPLETED);
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
        setStateByPartyStatus(Status.ERROR);
      }
    } catch (e) {
      setStateByPartyStatus(Status.ERROR);
    }
  }

  Future deleteParty(int id) async {
    EasyLoading.showToast("Deleting Party...");

    final res = await api.deleteParty(
        "Bearer ${GreetStorage.getAuthToken()!}", id, "hi");
    try {
      if (res.response.statusCode == 200) {
        refresh();
        getStateByPartyId(parentPartyId.value);
        EasyLoading.showSuccess("Party Deleted Successfully!");
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

  void reorderParty(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }

    final Datum party1 = partyLists!.removeAt(oldIndex)!;
    partyLists?.insert(newIndex, party1);
    // debugPrint('Reordered partyLists: ${partyLists}');
  }

  Future getStateList() async {
    isStateLoading.value = true;
    try {
      final res = await api.getStateList(
          "Bearer ${GreetStorage.getAuthToken()!}", "hi");
      stateList = [];
      stateNamesList.value = [];

      if (res.response.statusCode == 200) {
        StateModel model = StateModel.fromJson(res.data);
        stateList = model.data;
        stateNamesList.value = stateList.map((state) => state.state).toList();
        stateIdHashMap = {
          for (var state in stateList) state.state: state.stateId.toString()
        };
        isStateLoading.value = false;
      } else if (res.response.statusCode == 401) {
        handleApiStatus(401);
      } else {
        EasyLoading.showError(
            "${res.response.statusCode} ${res.response.statusMessage}");
      }
      isStateLoading.value = false;
    } catch (e) {
      isStateLoading.value = false;
    }
  }

  void uploadLogoPhoto(String photo) {
    logoPhoto.value = photo;
    update();
    logoPickerCtrl.isLoadingLogo.value = false;
    logoPickerCtrl.isLoadingLogo.refresh();
  }

  void removeLogo() {
    logoPhoto.value = '';
    update();
  }

  Future<void> uploadToFirebasePhoto(Uint8List galleryImage) async {
    isLoadingMore.value = true;
    Reference ref =
        FirebaseStorage.instanceFor(bucket: "post-karo-b0fe6.appspot.com")
            .ref()
            .child('jarvis')
            .child('image1');
    String id = const Uuid().v1();
    ref = ref.child(id);
    UploadTask uploadTask =
        ref.putData(galleryImage, SettableMetadata(contentType: 'image/jpeg'));
    TaskSnapshot snapshot = await uploadTask;
    firebaseImageUrl.value = await snapshot.ref.getDownloadURL();
    uploadMember(firebaseImageUrl.value);
  }

  void uploadMember(String photo) {
    partyMember.value.add(photo);
    partyMember.refresh();
    isLoadingMore.value = false;
    update();
  }
  void setParty({
    required String nameOfState,
    required int idOfState,
    required String nameOfParty,
    required int idOfParty,
    required String logo,
    required List<String>? membersList,
  }) {
    stateName.value = nameOfState;
    stateId.value = idOfState;
    partyName.value = nameOfParty;
    partyId.value = idOfParty;
    logoPhoto.value = logo;
    partyMember.value = membersList!;
    partyMember.refresh();
  }
}
