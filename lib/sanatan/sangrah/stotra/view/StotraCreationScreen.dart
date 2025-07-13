import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/Wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/viewmodel/StotraViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';

import '../../../../Utils/values/AppConstants.dart';

final StotraViewModel stotraCtrl = Get.put(StotraViewModel());

class StotraCreationScreen extends StatefulWidget {
  const StotraCreationScreen({super.key});

  @override
  State<StotraCreationScreen> createState() => _StotraCreationScreenState();
}

class _StotraCreationScreenState extends State<StotraCreationScreen> {
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
                formPadding(),
                sanatanGodSelector(context),

                /// POST TITLE
                creationSubTitle(
                    "title".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        stotraCtrl.stotraTitleTextCtrl.refresh();
                      },
                      maxLength: AppConstants.maxtitleLength,
                      controller: stotraCtrl.stotraTitleTextCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),

                formPadding(),
                creationSubTitle(
                    "description".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        stotraCtrl.stotraDescTextCtrl.refresh();
                      },
                      minLines: 5,
                      controller: stotraCtrl.stotraDescTextCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "description".tr,
                    )),

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
                        Get.back();
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
                          if (stotraCtrl
                              .stotraTitleTextCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter title");
                            return;
                          } else if (stotraCtrl
                              .stotraDescTextCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter Description");
                            return;
                          } else {
                            stotraCtrl.createStotra();
                          }
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
