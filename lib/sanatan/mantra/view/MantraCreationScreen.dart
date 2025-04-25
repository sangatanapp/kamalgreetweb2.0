import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';

class AddMantraScreen extends StatefulWidget {
  const AddMantraScreen({super.key});

  @override
  State<AddMantraScreen> createState() => _AddMantraScreenState();
}

class _AddMantraScreenState extends State<AddMantraScreen> {
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
                /// POST TITLE
                creationSubTitle(
                    "title".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        mantraCtrl.mantraTitleCtrl.refresh();
                      },
                      maxLength: 30,
                      controller: mantraCtrl.mantraTitleCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),

                formPadding(),
                creationSubTitle(
                    "description".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        mantraCtrl.mantraDescCtrl.refresh();
                      },
                      maxLength: 50,
                      controller: mantraCtrl.mantraDescCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "description".tr,
                    )),
                formPadding(),
                sanatanGodSelector(context),
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
                          if (mantraCtrl.mantraTitleCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter title");
                            return;
                          } else if (mantraCtrl
                              .mantraDescCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter Description");
                            return;
                          } else if (mantraCtrl.firebaseAudioUrl == "") {
                            EasyLoading.showError("Select Audio");
                            return;
                          } else {
                            mantraCtrl.createMantra();
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
