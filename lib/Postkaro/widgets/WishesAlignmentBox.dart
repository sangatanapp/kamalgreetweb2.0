import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import '../../../Utils/values/AppColors.dart';

Widget wishesAlignmentBox() {
  Widget buildAlignmentChip(String option) {
    return Row(
      children: [
        Obx(() => OutlinedButton(
              onPressed: () {
                postKaroCreationCtrl.selectWishesPosition(option);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:
                    postKaroCreationCtrl.selectedWishesPosition.value == option
                        ? AppColors.positionButton
                        : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    color: postKaroCreationCtrl.selectedWishesPosition.value == option
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  return Visibility(
    visible: subCategoryCtrl.fieldNameMapping.value.contains('wishes'),
    child: Container(
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 0.5, color: Colors.grey),
          borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'wishesMessage'.tr,
              style: GoogleFonts.poppins(
                  fontSize: 15, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                buildAlignmentChip('topLeft'),
                const SizedBox(
                  width: 20,
                ),
                buildAlignmentChip('topCenter'),
                const SizedBox(
                  width: 20,
                ),
                buildAlignmentChip('topRight'),
                const SizedBox(
                  width: 20,
                ),
                buildAlignmentChip('centerLeft'),
                const SizedBox(
                  width: 20,
                ),
                buildAlignmentChip('center'),
                const SizedBox(
                  width: 20,
                ),
                buildAlignmentChip('centerRight'),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
