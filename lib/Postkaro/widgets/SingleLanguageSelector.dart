import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../Utils/widgets/DynamicDropdown.dart';

Widget singleLanguageSelector() {
  return Row(
    children: [
      Expanded(
        child: DynamicDropdown(
            length: dashCtr.languageNameList.length,
            labelText: 'selectLanguage'.tr,
            selectedValue: dashCtr.languageName.value,
            hintText: 'selectLanguage'.tr,
            dropDownList: dashCtr.languageNameList,
            onChange: (value) {
              int selectedIndex = dashCtr.languageNameList.indexOf(value);
              dashCtr.languageName.value =
                  dashCtr.languageNameList[selectedIndex];
              dashCtr.languageShortName.value =
                  dashCtr.languageList[selectedIndex].languageCode;

              dashCtr.languageId.value =
                  dashCtr.languageList[selectedIndex].id.toString();
              tagController.getTagList(dashCtr.languageShortName.value);
            }),
      ),
    ],
  );
}
