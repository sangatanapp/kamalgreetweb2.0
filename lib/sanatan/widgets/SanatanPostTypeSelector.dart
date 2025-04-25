import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../Utils/widgets/DynamicDropdown.dart';

Widget sanatanPostTypeSelector(BuildContext context, bool fromCreationScreen) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: DynamicDropdown(
                length: tagController.categorySelected.value.length,
                labelText: 'addCategory'.tr,
                selectedValue: tagController.categorySelected.value,
                hintText: 'category'.tr,
                dropDownList: const ["post", "video"],
                onChange: (value) {
                  if (tagController.selectedCategoryList.value
                      .contains(value)) {
                    if (fromCreationScreen) {
                      EasyLoading.showInfo('Type Already Selected!');
                    }
                    return;
                  } else {
                    if (value == 'video') {
                      tagController.clearCategory();
                    } else {
                      if (tagController.selectedCategoryList
                          .contains('video')) {
                        tagController.selectedCategoryList.remove('video');
                      }
                    }
                    tagController.categorySelected.value = value;
                    tagController.selectedCategoryList.value.add(value);
                  }
                }),
          ),
        ],
      ),
      Visibility(
        visible: fromCreationScreen,
        child: const SizedBox(
          height: 3,
        ),
      ),
      Visibility(
        visible: fromCreationScreen,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Icon(
              Icons.info,
              size: 12,
              color: Colors.grey,
            ),
            const SizedBox(
              width: 2,
            ),
            Text(
              'pressEnterCategory'.tr,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
      Visibility(
        visible: fromCreationScreen,
        child: const SizedBox(
          height: 5,
        ),
      ),
      Visibility(
        visible: fromCreationScreen,
        child: Obx(() {
          if (tagController.selectedCategoryList.value.isNotEmpty) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children: tagController.selectedCategoryList.value.map((tag) {
                return Chip(
                  labelStyle: TextStyle(color: Colors.blue.shade800),
                  backgroundColor: Colors.orange.shade100,
                  label: Text(
                    tag,
                    style: GoogleFonts.poppins(),
                  ),
                  onDeleted: () {
                    tagController.selectedCategoryList.remove(tag);
                  },
                  deleteIconColor: Colors.blue.shade800,
                );
              }).toList(),
            );
          } else {
            return const SizedBox();
          }
        }),
      ),
    ],
  );
}
