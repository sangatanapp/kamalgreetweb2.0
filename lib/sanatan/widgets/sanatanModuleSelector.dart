import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import '../../../Utils/values/AppColors.dart';

Widget sanatanModuleSelector({required bool isMobile}) {
  return SizedBox(
    height: 50,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: sanatanDashboardCtrl.moduleName.length,
      itemBuilder: (context, index) {
        return Obx(
          () => GestureDetector(
            onTap: () {
              if (index == 1) {
                wallpaperCtrl.getWallpaper();
              } else if (index == 2) {
                mantraCtrl.sangrahSelectedModule.value = 0;
                mantraCtrl.sangrahSelectedModule.refresh();
                mantraCtrl.getMantra();
              } else if (index == 3) {
                darshanCtrl.getDarshan();
              } else {
                sanatanDashboardCtrl.filterType.value = "ONGOING";
                sanatanDashboardCtrl.filterType.refresh();
                sanatanDashboardCtrl.getSanatanPost();
              }
              sanatanDashboardCtrl.selectedModule.value = index;
              sanatanDashboardCtrl.selectedModule.refresh();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: index == 0
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(10),
                          bottomLeft: Radius.circular(10))
                      : index == 3
                          ? const BorderRadius.only(
                              topRight: Radius.circular(10),
                              bottomRight: Radius.circular(10))
                          : null,
                  border: Border.all(color: Colors.grey),
                  color: sanatanDashboardCtrl.selectedModule.value == index
                      ? AppColors.primaryColor
                      : Colors.white),
              height: isMobile ? MediaQuery.of(context).size.width * 0.1 : MediaQuery.of(context).size.width * 0.03,
              width: isMobile ? MediaQuery.of(context).size.width * 0.3 : MediaQuery.of(context).size.width * 0.19,
              child: Center(
                child: Text(
                  sanatanDashboardCtrl.moduleName[index],
                  style: GoogleFonts.poppins(
                      color: sanatanDashboardCtrl.selectedModule.value == index
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
  );
}
