import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Postkaro/viewmodel/PostKaroCreationViewModel.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/CategorySelector.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/NotificationBox.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/PartySelector.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/SingleLanguageSelector.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/SubCategorySelector.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/WishesAlignmentBox.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/EndDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/StartDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import '../../Utils/internet/ConnectivityController.dart';
import '../../Utils/values/AppColors.dart';
import '../../Utils/widgets/DynamicAppbar.dart';
import '../../Utils/widgets/DynamicButton.dart';
import '../../Utils/widgets/DynamicTextfield.dart';

class CreationScreen extends StatefulWidget {
  final String? id;

  const CreationScreen({super.key, this.id});

  @override
  State<CreationScreen> createState() => _CreationScreenState();
}

class _CreationScreenState extends State<CreationScreen> {
  @override
  void initState() {
    postKaroCreationCtrl.isLoading.value = false;
    postKaroCreationCtrl.isLoading.refresh();
    quranViewCtrl.selectedQuranCountry = "";
    quranViewCtrl.selectedQuranCountryLanguage = "";
    dashCtr.languageShortName.value = '';
    postKaroCreationCtrl.cropRatio.value = "1:1";
    postKaroCreationCtrl.finalPartyLogo.value = "";
    postKaroCreationCtrl.finalNamePlate.value = "";
    postKaroCreationCtrl.finalBackground.value = "";
    postKaroCreationCtrl.finalPartyName.value = "";
    postKaroCreationCtrl.selectedPartyLogo.value = -1;
    postKaroCreationCtrl.selectedNamePlate.value = -1;
    postKaroCreationCtrl.selectedBackground.value = -1;
    postKaroCreationCtrl.startDateString.value = '';
    postKaroCreationCtrl.startTimeString.value = '';
    postKaroCreationCtrl.endDateString.value = '';
    postKaroCreationCtrl.endTimeString.value = '';
    postKaroCreationCtrl.selectedPartyNameList.value = [];
    postKaroCreationCtrl.partyIdList.value = [];
    postKaroCreationCtrl.selectedPartyNameList.refresh();
    postKaroCreationCtrl.partyIdList.refresh();
    postKaroCreationCtrl.whichAppSelected.value = "postkaro";
    postKaroCreationCtrl.whichAppSelected.refresh();
    tagController.selectedGuruName.value = [];
    tagController.selectedGuruId.value = [];

    Timer(const Duration(milliseconds: 2), () {
      dashCtr.stateName.value = '';
      dashCtr.stateId.value = 0;
      dashCtr.languageName.value = '';
      dashCtr.languageId.value = '0';
      dashCtr.languageShortName.value = '';
      dashCtr.selectedLanguageList.value = [];
      dashCtr.selectedStateList.value = [];
      postKaroCreationCtrl.partyList = [];
      tagController.allSuggestions.clear();
      tagController.selectedCategoryList.value.clear();
      tagController.categorySelected.value = 'post';
      tagController.selectedCategoryList.value.add('post');
      // postKaroCreationCtrl.whichAppSelected.value = '';
      postKaroCreationCtrl.videoRatio.value = '1';
      postKaroCreationCtrl.videoPathForFirebase = null;
      postKaroCreationCtrl.videoFirebaseUrl.value = '';
      postKaroCreationCtrl.mainPostImage.value = '';
      postKaroCreationCtrl.progress = 0.0.obs;
      postKaroCreationCtrl.message = "Initializing...".obs;
      print(" i am in creation again");
      cardCreationCtrl.selectedPostKaroNotificationList.value = [
        "postshare",
        "postkaro",
        "sharepost",
        "politicalposter"
      ];
      cardCreationCtrl.selectedPostKaroNotificationList.refresh();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () {
          if (connectivityController.connectionType ==
                  MConnectivityResult.wifi ||
              connectivityController.connectionType ==
                  MConnectivityResult.mobile) {
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
    bool multiLangEnabled = false;

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
                            controller: postKaroCreationCtrl.startDate,
                            readOnly: true,
                            onTap: () async {
                              await selectStartDateAndTime(
                                context: context,
                                startDateController:
                                    postKaroCreationCtrl.startDate,
                              );
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
                            controller: postKaroCreationCtrl.endDate,
                            readOnly: true,
                            onTap: () async {
                              await selectEndDateAndTime(
                                  context: context,
                                  endDateController:
                                      postKaroCreationCtrl.endDate);
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
                      maxLength: AppConstants.maxtitleLength,
                      controller: postKaroCreationCtrl.titleController.value,
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
                      maxLines: 3,
                      controller: postKaroCreationCtrl.sharingContent.value,
                      fillColor: AppColors.whiteCard,
                      hintText: "sharingContent".tr,
                    )),
                formPadding(),

                /// LANGUAGE
                Obx(
                  () => creationSubTitle(
                      'language'.tr,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// SINGLE LANGUAGE
                          singleLanguageSelector(),
                        ],
                      )),
                ),
                formPadding(),

                /// CATEGORY & SUB CATEGORY
                Obx(
                  () => Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// CATEGORY
                      Flexible(
                          flex: 1,
                          child: creationSubTitle(
                              "category".tr, categorySelector(context))),

                      formRowPadding(),

                      /// SUB CATEGORY
                      Flexible(
                          flex: 1,
                          child: creationSubTitle(
                              "subCategory".tr, subCategorySelector(context))),
                    ],
                  ),
                ),

                formPadding(),

                /// PARTY & STATE
                partySelector(),
                formPadding(),

                /// WISHES ALIGNMENT
                wishesAlignmentBox(),

                /// IMAGE SETTINGS BOX
                postImageBox(
                    context: context,
                    isPhoto: postKaroCreationCtrl.getPostType()),

                /// NOTIFICATION BOX
                notificationBox(),

                /// CANCEL & SUBMIT BUTTON
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    /// CANCEL BUTTON
                    SizedBox(
                      height: 100,
                      child: DynamicButton(
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
                          postKaroCreationCtrl.checkFields();
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
