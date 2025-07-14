import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/data/api/PostkaroApi.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/TagListModel.dart';
import 'package:kamal_greet_web_2/apicalling/ApiCallBaseOption.dart';
import 'package:kamal_greet_web_2/apicalling/StatusCodeResponse.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/main.dart';

class SubCategoryViewModel extends GetxController {
  final api = PostkaroApi(apiCallBaseOption());

  List<TagName?>? tagList = [];
  Map<String, String> tagHashMap = {};
  Map<String, String> fieldNameHashMap = {};
  RxList<String> tagMapping = <String>[].obs;
  RxList<String> fieldNameMapping = <String>[].obs;

  final tagNameController = TextEditingController().obs;

  RxList<int> idTag = <int>[].obs;
  RxString tagPhotos = ''.obs;
  RxString firebaseImageUrl = "".obs;

  RxBool isLoadingTag = false.obs;
  RxList<String> allSuggestions = <String>[].obs;
  Map<String, String> allGuruHashMap = {};
  Map<String, String> allGuruNameHashMap = {};

  RxList<String> allGuruSuggestions = <String>[].obs;

  RxList<String> categoryList = <String>['post', 'frame', 'video'].obs;
  RxSet<String> selectedCategoryList = <String>{}.obs;
  RxString categorySelected = 'post'.obs;
  RxDouble videoRatio = (1.1).obs;
  RxList<String> viewtagList = <String>[].obs;
  final catergoryCtrl = TextEditingController().obs;
  final subCatergoryCtrl = TextEditingController().obs;
  final guruNameCtrl = TextEditingController().obs;

  RxList<int> selectedIndices = <int>[].obs;

  void toggleSelection(int index) {
    if (selectedIndices.contains(index)) {
      selectedIndices.remove(index);
    } else {
      selectedIndices.add(index);
    }
  }

  bool isSelected(int index) => selectedIndices.contains(index);

  void reorderTags(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex -= 1;
    }
    final TagName party = tagList!.removeAt(oldIndex)!;
    tagList?.insert(newIndex, party);
  }

  void addTag(String tag, String tagId, String fieldName) {
    if (tag.isNotEmpty && !tagMapping.contains(tag)) {
      tagMapping.add(tag);
      fieldNameMapping.add(fieldName);
      idTag.add(int.parse(tagId));
    }
  }

  List<String> getKeysFromTagIds(List<String> tagIds) {
    Map<String, String> reversedMap =
        tagHashMap.map((key, value) => MapEntry(value, key));
    Map<String, String> reversedFieldMap =
        fieldNameHashMap.map((key, value) => MapEntry(value, key));

    List<String> keys = tagIds.map((tagId) {
      return reversedMap[tagId] ?? 'Loading';
    }).toList();

    return keys;
  }

  Future getTagList(String languageCode) async {
    try {
      final res = await api.getTagList(
          "Bearer ${GreetStorage.getAuthToken()!}", languageCode, 'post');
      tagList = [];
      viewtagList.value = [];
      if (res.response.statusCode == 200) {
        TagListModel model = TagListModel.fromJson(res.data);
        tagList = model.tagName;
        allSuggestions.clear();
        tagHashMap = {};
        fieldNameHashMap = {};
        for (int i = 0; i < tagList!.length; i++) {
          if (tagList![i]?.tagName != null && tagList![i]?.id != null) {
            allSuggestions
                .add('${tagList![i]?.tagName} ( ${tagList![i]?.displayTag} )');
            viewtagList
                .add('${tagList![i]?.tagName} ( ${tagList![i]?.displayTag} )');
            tagHashMap[
                    '${tagList![i]?.tagName} ( ${tagList![i]?.displayTag} )'] =
                tagList![i]!.id.toString();
            fieldNameHashMap[
                    '${tagList![i]?.tagName} ( ${tagList![i]?.displayTag} )'] =
                tagList![i]!.fieldName.toString();
          }
        }
        allSuggestions.refresh();
        viewtagList.refresh();
        update();
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

  void removeTag(String tag, String tagId, String fieldName) {
    tagMapping.remove(tag);
    fieldNameMapping.remove(fieldName);
    idTag.remove(int.parse(tagId));
    update();
  }

  clearCategory() {
    selectedCategoryList.clear();
    update();
  }

  void setTag({required String? tagName, required String? tagLogo}) {
    tagNameController.value.text = tagName!;
    tagPhotos.value = tagLogo!;
  }

  void uploadTagPhoto(String photo) {
    tagPhotos.value = photo;
    update();
    isLoadingTag.value = false;
  }

  Future createTag() async {
    EasyLoading.showProgress(20);
    var data = {
      "tag_name": tagNameController.value.text,
      "tag_imageurl": tagPhotos.value.toString()
    };
    final res = await api.createTag(
        "Bearer ${GreetStorage.getAuthToken()!}", data, "hi");
    try {
      if (res.response.statusCode == 200) {
        EasyLoading.showSuccess("tagAddedSuccessfully".tr);
        getTagList('en');
        Navigator.pop(NavigationService.navigatorKey.currentContext!);
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

  void removeTagImage() {
    tagPhotos.value = '';
    update();
  }
}
