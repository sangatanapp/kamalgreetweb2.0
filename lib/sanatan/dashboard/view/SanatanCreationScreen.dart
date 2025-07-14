import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/EndDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/StartDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/viewmodel/SanatanCreationViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanPostTypeSelector.dart';

import '../../../Utils/internet/ConnectivityController.dart';
import '../../../Utils/values/AppConstants.dart';
import '../../widgets/PostImageBox.dart';

final SanatanCreationViewModel sanatanCreationCtrl =
    Get.put(SanatanCreationViewModel());

class SanatanCreationScreen extends StatefulWidget {
  const SanatanCreationScreen({super.key});

  @override
  State<SanatanCreationScreen> createState() => _SanatanCreationScreenState();
}

class _SanatanCreationScreenState extends State<SanatanCreationScreen> {
  final controller = Get.put(ConnectivityController());

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () {
          if (controller.connectionType == MConnectivityResult.wifi ||
              controller.connectionType == MConnectivityResult.mobile) {
            return Scaffold(
                backgroundColor: AppColors.creationScreenBackground,
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.16),
                  child: formWidget(context),
                ));
          } else {
            return const ConnectivityWidget();
          }
        },
      );
    });
  }

  Widget formWidget(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.creationScreenBackground,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// START DATE & END DATE
                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: creationSubTitle(
                          "startDate".tr,
                          DynamicTextfield(
                            controller: sanatanCreationCtrl.startDate,
                            readOnly: true,
                            onTap: () async {
                              await selectStartDateAndTime(
                                  context: context,
                                  startDateController:
                                      sanatanCreationCtrl.startDate);
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
                            controller: sanatanCreationCtrl.endDate,
                            readOnly: true,
                            onTap: () async {
                              await selectEndDateAndTime(
                                  context: context,
                                  endDateController:
                                      sanatanCreationCtrl.endDate);
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
                ),
                formPadding(),

                /// POST TITLE
                creationSubTitle(
                    "title".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        sanatanCreationCtrl.titleController.refresh();
                      },
                      maxLength: AppConstants.maxtitleLength,
                      controller: sanatanCreationCtrl.titleController.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),
                formPadding(),

                /// SHARING CONTENT
                creationSubTitle(
                    "postContent".tr,
                    DynamicTextfield(
                      maxLength: 150,
                      // height: 100,
                      maxLines: 3,
                      controller: sanatanCreationCtrl.sharingContent.value,
                      fillColor: AppColors.whiteCard,
                      hintText: "sharingContent".tr,
                    )),

                formPadding(),
                sanatanGodSelector(context),
                formPadding(),
                creationSubTitle(
                  "Post type".tr,
                  sanatanPostTypeSelector(context, true),
                ),
                formPadding(),

                /// IMAGE SETTINGS BOX
                postImageBox(
                    context: context,
                    isPhoto: sanatanDashboardCtrl.getPostType()),
                formPadding(),

                /// CANCEL & SUBMIT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// CANCEL BUTTON
                    DynamicButton(
                      text: 'cancel'.tr,
                      height: MediaQuery.of(context).size.width * 0.05,
                      width: MediaQuery.of(context).size.width * 0.3,
                      textSize: 16,
                      radius: 50,
                      textColor: Colors.black,
                      boldness: FontWeight.w500,
                      backgroundColor: Colors.white,
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),

                    /// SUBMIT BUTTON
                    DynamicButton(
                        text: 'creationTitle'.tr,
                        height: MediaQuery.of(context).size.width * 0.05,
                        width: MediaQuery.of(context).size.width * 0.3,
                        textSize: 16,
                        radius: 50,
                        textColor: Colors.black,
                        boldness: FontWeight.w500,
                        backgroundColor: AppColors.creationSubmitButton,
                        onTap: () {
                          sanatanCreationCtrl.checkFields();
                        })
                  ],
                ),
                formPaddingPlus(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
