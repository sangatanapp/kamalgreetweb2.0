import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/viewmodel/SanatanCreationViewModel.dart';

import '../../../Utils/internet/ConnectivityController.dart';

final CardCreationViewModel cardCreationCtrl = Get.put(CardCreationViewModel());
final SanatanCreationViewModel sanatanCreationCtrl =
    Get.put(SanatanCreationViewModel());
final CreationVideoUploadViewModel creationVideoUploadCtrl =
    Get.put(CreationVideoUploadViewModel());

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
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.16),
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
                              controller: postController.startDate.value,
                            readOnly: true,
                            onTap: () async {
                              await selectStartDateAndTime(context);
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
                            controller: postController.endDate.value,
                            readOnly: true,
                            onTap: () async {
                              await selectEndDateAndTime(context);
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
                        postController.titleController.refresh();
                      },
                      maxLength: 50,
                      controller: postController.titleController.value,
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
                      controller: postController.sharingContent.value,
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
                    context: context, isPhoto: postController.getPostType()),
                formPadding(),

                /// CANCEL & SUBMIT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// CANCEL BUTTON
                    DynamicButton(
                      text: 'cancel'.tr,
                      height: Get.width * 0.05,
                      width: Get.width * 0.3,
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
                        height: Get.width * 0.05,
                        width: Get.width * 0.3,
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
