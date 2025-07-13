import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';

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
                length: sanatanDashboardCtrl.categorySelected.value.length,
                labelText: 'addCategory'.tr,
                selectedValue: sanatanDashboardCtrl.categorySelected.value,
                hintText: 'category'.tr,
                dropDownList: ["post", "video"],
                onChange: (value) {
                  if (sanatanDashboardCtrl.selectedCategoryList.value
                      .contains(value)) {
                    if (fromCreationScreen) {
                      EasyLoading.showInfo('Type Already Selected!');
                    }
                    return;
                  } else {
                    if (value == 'video') {
                      sanatanDashboardCtrl.clearCategory();
                    } else {
                      if (sanatanDashboardCtrl.selectedCategoryList
                          .contains('video')) {
                        sanatanDashboardCtrl.selectedCategoryList
                            .remove('video');
                      }
                    }
                    sanatanDashboardCtrl.categorySelected.value = value;
                    sanatanDashboardCtrl.selectedCategoryList.value.add(value);
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
          if (sanatanDashboardCtrl.selectedCategoryList.value.isNotEmpty) {
            return Wrap(
              spacing: 8.0,
              runSpacing: 4.0,
              children:
                  sanatanDashboardCtrl.selectedCategoryList.value.map((tag) {
                return Chip(
                  labelStyle: TextStyle(color: Colors.blue.shade800),
                  backgroundColor: Colors.orange.shade100,
                  label: Text(
                    tag,
                    style: GoogleFonts.poppins(),
                  ),
                  onDeleted: () {
                    sanatanDashboardCtrl.selectedCategoryList.remove(tag);
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
