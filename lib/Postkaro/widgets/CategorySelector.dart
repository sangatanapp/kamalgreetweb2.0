import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import '../../../Utils/widgets/DynamicDropdown.dart';

Widget categorySelector(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: DynamicDropdown(
                length: subCategoryCtrl.categorySelected.value.length,
                labelText: 'addCategory'.tr,
                selectedValue: subCategoryCtrl.categorySelected.value,
                hintText: 'category'.tr,
                dropDownList: subCategoryCtrl.categoryList.value,
                onChange: (value) {
                  if (subCategoryCtrl.selectedCategoryList.value
                      .contains(value)) {
                    EasyLoading.showInfo('Type Already Selected!');
                    return;
                  } else {
                    if (value == 'video') {
                      subCategoryCtrl.clearCategory();
                    } else {
                      if (subCategoryCtrl.selectedCategoryList
                          .contains('video')) {
                        subCategoryCtrl.selectedCategoryList.remove('video');
                      }
                    }
                    subCategoryCtrl.categorySelected.value = value;
                    subCategoryCtrl.selectedCategoryList.value.add(value);
                  }
                }),
          ),
        ],
      ),
      const SizedBox(height: 3),
      Row(
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
      const SizedBox(height: 5),
      Obx(() {
        if (subCategoryCtrl.selectedCategoryList.value.isNotEmpty) {
          return Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: subCategoryCtrl.selectedCategoryList.value.map((tag) {
              return Chip(
                labelStyle: TextStyle(color: Colors.blue.shade800),
                backgroundColor: Colors.orange.shade100,
                label: Text(
                  tag,
                  style: GoogleFonts.poppins(),
                ),
                onDeleted: () {
                  subCategoryCtrl.selectedCategoryList.remove(tag);
                },
                deleteIconColor: Colors.blue.shade800,
              );
            }).toList(),
          );
        } else {
          return const SizedBox();
        }
      }),
    ],
  );
}
