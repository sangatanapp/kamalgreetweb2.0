import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/view/AartiCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/view/ChaleesaCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/view/StotraCreationScreen.dart';
import '../../../Utils/values/AppColors.dart';

Widget sangrahModuleSelector() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: SizedBox(
      height: 50,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: mantraCtrl.sangrahModuleName.length,
        itemBuilder: (context, index) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                if (index == 1) {
                  aartiCtrl.getAarti();
                } else if (index == 2) {
                  chaleesaCtrl.getChallesa();
                } else if (index == 3) {
                  stotraCtrl.getStotra();
                } else if (index == 4) {
                  ringtoneCtrl.getRingtone();
                } else {
                  mantraCtrl.getMantra();
                }
                mantraCtrl.sangrahSelectedModule.value = index;
                mantraCtrl.sangrahSelectedModule.refresh();
              },
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: index == 0
                        ? const BorderRadius.only(
                            topLeft: Radius.circular(10),
                            bottomLeft: Radius.circular(10))
                        : index == 4
                            ? const BorderRadius.only(
                                topRight: Radius.circular(10),
                                bottomRight: Radius.circular(10))
                            : null,
                    border: Border.all(color: Colors.grey),
                    color: mantraCtrl.sangrahSelectedModule.value == index
                        ? AppColors.primaryColor
                        : Colors.white),
                height: Get.width * 0.03,
                width: 170,
                child: Center(
                  child: Text(
                    mantraCtrl.sangrahModuleName[index],
                    style: GoogleFonts.poppins(
                        color: mantraCtrl.sangrahSelectedModule.value == index
                            ? Colors.white
                            : Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    ),
  );
}
