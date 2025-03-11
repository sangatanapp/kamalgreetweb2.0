import 'package:flutter/material.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';

class AppConstants {
  static double titleSize = 16;
  static double titleSize1 = 24;
  static double titleSize2 = 20;
  static double subTitleSize = 14;
  static double largHeading = 30;
  static Icon loginIcon = Icon(
    Icons.mobile_screen_share,
    size: 100,
    color: AppColors.primaryColor,
  );

  /// NEW FLOW
  static BorderRadius borderRadius = BorderRadius.circular(12);
  static BorderSide borderSide = BorderSide(
      color: AppColors.borderColor, width: AppConstants.borderWidth);
  static BoxBorder boxBorder = Border.all(
      color: AppColors.borderColor, width: AppConstants.borderWidth);

  static double borderWidth = 0.5;
}
