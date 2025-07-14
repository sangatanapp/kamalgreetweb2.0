import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/main.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import '../../../Utils/values/AppColors.dart';

Widget sanatanOngoingUpcomingTabs({
  required BuildContext context,
  required String tabName,
  required Function() onPress,
  required bool isMobile,
}) {
  double radius = 8;
  Color tabBackgroundColor = AppColors.ongoingButton;
  Color tabTextColor = AppColors.upcomingButton;
  BorderRadius borderRad = BorderRadius.only(
      topRight: Radius.circular(radius), bottomRight: Radius.circular(radius));

  if (tabName == 'ONGOING') {
    borderRad = BorderRadius.only(
        topLeft: Radius.circular(radius), bottomLeft: Radius.circular(radius));
  }

  if (tabName == 'ONGOING') {
    if (sanatanDashboardCtrl.filterType.value == 'ONGOING') {
      tabBackgroundColor = AppColors.ongoingButton;
      tabTextColor = AppColors.upcomingButton;
    } else {
      tabBackgroundColor = AppColors.upcomingButton;
      tabTextColor = AppColors.ongoingButton;
    }
  } else if (tabName == 'UPCOMING') {
    if (sanatanDashboardCtrl.filterType.value == 'ONGOING') {
      tabBackgroundColor = AppColors.upcomingButton;
      tabTextColor = AppColors.ongoingButton;
    } else {
      tabBackgroundColor = AppColors.ongoingButton;
      tabTextColor = AppColors.upcomingButton;
    }
  }
  return GestureDetector(
    onTap: onPress,
    child: Container(
      height: isMobile
          ? MediaQuery.of(context).size.width * 0.1
          : MediaQuery.of(context).size.width * 0.02,
      width: isMobile
          ? MediaQuery.of(context).size.width * 0.3
          : MediaQuery.of(context).size.width * 0.07,
      decoration: BoxDecoration(
        color: tabBackgroundColor,
        border: Border.all(color: AppColors.ongoingButton),
        borderRadius: borderRad,
      ),
      child: Center(
        child: Text(
          tabName,
          textAlign: TextAlign.center,
          style: TextStyle(color: tabTextColor),
        ),
      ),
    ),
  );
}
