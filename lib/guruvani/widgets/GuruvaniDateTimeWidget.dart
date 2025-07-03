import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';

import '../../Utils/widgets/EndDateSelector.dart';
import '../../Utils/widgets/StartDateSelector.dart';
import '../view/GuruvaniDashboard.dart';

Widget guruvaniDateTimeWidget({required BuildContext context}) {
  return Row(
    children: [
      Flexible(
        flex: 1,
        child: creationSubTitle(
            "startDate".tr,
            DynamicTextfield(
              controller: guruvaniCtrl.startDate,
              readOnly: true,
              onTap: () async {
                await selectStartDateAndTime(
                    context: context,
                    startDateController: guruvaniCtrl.startDate);
              },
              hintText: 'startDate'.tr,
              labelText: "startDate".tr,
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
              height: 55,
            )),
      ),
      const SizedBox(
        width: 20,
      ),
      Flexible(
        flex: 1,
        child: creationSubTitle(
            "endDate".tr,
            DynamicTextfield(
              controller: guruvaniCtrl.endDate,
              readOnly: true,
              onTap: () async {
                await selectEndDateAndTime(
                    context: context, endDateController: guruvaniCtrl.endDate);
              },
              hintText: "endDate".tr,
              labelText: "endDate".tr,
              suffixIcon: const Icon(
                Icons.calendar_today,
                color: Colors.grey,
              ),
              height: 55,
            )),
      ),
    ],
  );
}
