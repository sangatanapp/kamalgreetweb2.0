import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/values/AppColors.dart';
import '../../Utils/widgets/DynamicButton.dart';
import '../view/GuruvaniDashboard.dart';

Widget guruvaniCreationButtons({required BuildContext context}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      /// CANCEL BUTTON
      DynamicButton(
        text: "Reset",
        height: MediaQuery.of(context).size.width * 0.035,
        width: MediaQuery.of(context).size.width * 0.1,
        textSize: 16,
        radius: 30,
        textColor: Colors.black,
        boldness: FontWeight.w500,
        backgroundColor: Colors.white,
        onTap: () {},
      ),

      /// SUBMIT BUTTON
      DynamicButton(
          text: 'creationTitle'.tr,
          height: MediaQuery.of(context).size.width * 0.035,
          width: MediaQuery.of(context).size.width * 0.1,
          textSize: 16,
          radius: 30,
          textColor: Colors.black,
          boldness: FontWeight.w500,
          backgroundColor: AppColors.creationSubmitButton,
          onTap: () {
            guruvaniCtrl.checkFields();
          })
    ],
  );
}
