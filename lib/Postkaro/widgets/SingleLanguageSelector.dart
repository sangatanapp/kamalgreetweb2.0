import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import '../../../Utils/widgets/DynamicDropdown.dart';

Widget singleLanguageSelector() {
  return Row(
    children: [
      Expanded(
        child: DynamicDropdown(
            length: postKaroDashboardCtrl.languageNameList.length,
            labelText: 'selectLanguage'.tr,
            selectedValue: postKaroDashboardCtrl.languageName.value,
            hintText: 'selectLanguage'.tr,
            dropDownList: postKaroDashboardCtrl.languageNameList,
            onChange: (value) {
              int selectedIndex =
                  postKaroDashboardCtrl.languageNameList.indexOf(value);
              postKaroDashboardCtrl.languageName.value =
                  postKaroDashboardCtrl.languageNameList[selectedIndex];
              postKaroDashboardCtrl.languageShortName.value =
                  postKaroDashboardCtrl
                      .languageList[selectedIndex].languageCode;

              postKaroDashboardCtrl.languageId.value = postKaroDashboardCtrl
                  .languageList[selectedIndex].id
                  .toString();
              subCategoryCtrl
                  .getTagList(postKaroDashboardCtrl.languageShortName.value);
            }),
      ),
    ],
  );
}
