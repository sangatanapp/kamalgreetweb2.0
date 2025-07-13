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
import 'package:kamal_greet_web_2/main.dart';
import 'package:kamal_greet_web_2/sanatan/Wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';

import '../../../../Utils/values/AppConstants.dart';

class RingtoneCreationScreen extends StatefulWidget {
  const RingtoneCreationScreen({super.key});

  @override
  State<RingtoneCreationScreen> createState() => _RingtoneCreationScreenState();
}

class _RingtoneCreationScreenState extends State<RingtoneCreationScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
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
                        ringtoneCtrl.ringtoneTitleCtrl.refresh();
                      },
                      maxLength: AppConstants.maxtitleLength,
                      controller: ringtoneCtrl.ringtoneTitleCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),

                formPadding(),
                creationSubTitle(
                    "description".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        ringtoneCtrl.ringtoneDescCtrl.refresh();
                      },
                      maxLength: 50,
                      controller: ringtoneCtrl.ringtoneDescCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "description".tr,
                    )),
                formPadding(),
                sanatanGodSelector(
                    NavigationService.navigatorKey.currentContext!),
                formPadding(),

                Row(
                  children: [
                    Flexible(
                      flex: 1,
                      child: RadioListTile(
                          value: 0,
                          groupValue: ringtoneCtrl.selectedTone.value,
                          onChanged: (value) {
                            ringtoneCtrl.selectedTone.value = value!;
                            ringtoneCtrl.selectedTone.refresh();
                          },
                          title: Text("Ringtone")),
                    ),
                    Flexible(
                      flex: 1,
                      child: RadioListTile(
                          value: 1,
                          groupValue: ringtoneCtrl.selectedTone.value,
                          onChanged: (value) {
                            ringtoneCtrl.selectedTone.value = value!;
                            ringtoneCtrl.selectedTone.refresh();
                          },
                          title: Text("MsgTone")),
                    )
                  ],
                ),

                formPadding(),

                /// IMAGE SETTINGS BOX
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    creationSubTitle(
                      "Upload".tr,
                      GestureDetector(
                        onTap: () {
                          ringtoneCtrl.pickAndUploadAudio();
                        },
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              border:
                                  Border.all(width: 0.5, color: Colors.grey)),
                          child: Align(
                            alignment: Alignment.center,
                            child: ringtoneCtrl.firebaseAudioUrl.value == ""
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.audio_file),
                                      const SizedBox(height: 15),
                                      Flexible(
                                        child: Text(
                                          "Upload Audio".tr,
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                      ),
                                      Flexible(
                                        child: Text(
                                          "accepts mp3".tr,
                                          style: GoogleFonts.poppins(
                                            fontSize: 10,
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.audiotrack),
                                      const SizedBox(height: 15),
                                      Flexible(
                                        child: Text(
                                          textAlign: TextAlign.center,
                                          "Audio Adding Done".tr,
                                          style:
                                              GoogleFonts.poppins(fontSize: 14),
                                        ),
                                      ),
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
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
                          if (ringtoneCtrl
                              .ringtoneTitleCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter title");
                            return;
                          } else if (ringtoneCtrl
                              .ringtoneDescCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter Description");
                            return;
                          } else if (ringtoneCtrl.firebaseAudioUrl == "") {
                            EasyLoading.showError("Select Audio");
                            return;
                          } else {
                            ringtoneCtrl.createRingtone();
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
