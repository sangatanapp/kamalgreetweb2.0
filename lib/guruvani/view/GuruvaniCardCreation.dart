import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicAppbar.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/EndDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/StartDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/guruvani/widgets/GuruSelector.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'GuruvaniDashboard.dart';

class GuruvaniCardCreation extends StatelessWidget {
  const GuruvaniCardCreation({super.key});

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
                appBar: AppBar(
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  actions: const [DynamicAppbar()],
                ),
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
                            controller: guruvaniCtrl.startDate.value,
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
                            controller: guruvaniCtrl.endDate.value,
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
                        guruvaniCtrl.titleController.refresh();
                      },
                      maxLength: 50,
                      controller: guruvaniCtrl.titleController.value,
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
                      controller: guruvaniCtrl.sharingContent.value,
                      fillColor: AppColors.whiteCard,
                      hintText: "sharingContent".tr,
                    )),
                formPadding(),
                Obx(
                  () => creationSubTitle("Select Guru", guruSelector(context)),
                ),
                formPadding(),

                // /// IMAGE SETTINGS BOX
                // postImageBox(
                //     context: context, isPhoto: guruvaniCtrl.getPostType()),
                //
                // /// NOTIFICATION BOX
                // notificationBox(),

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
                          guruvaniCtrl.checkFields();
                        })

                    // widget.id == ""
                    //     ? DynamicButton(
                    //         text: 'creationTitle'.tr,
                    //         height: Get.width * 0.05,
                    //         width: Get.width * 0.3,
                    //         textSize: 16,
                    //         radius: 50,
                    //         textColor: Colors.black,
                    //         boldness: FontWeight.w500,
                    //         backgroundColor: AppColors.creationSubmitButton,
                    //         onTap: () {
                    //           guruvaniCtrl.checkFields();
                    //         })
                    //     : DynamicButton (
                    //         text: 'update'.tr,
                    //         height: Get.width * 0.05,
                    //         width: Get.width * 0.3,
                    //         textSize: 16,
                    //         radius: 50,
                    //         textColor: Colors.black,
                    //         boldness: FontWeight.w500,
                    //         backgroundColor: AppColors.creationSubmitButton,
                    //         onTap: () async {
                    //           // if (!(tagController.tagMapping.value
                    //           //         .contains('political')) &&
                    //           //     (guruvaniCtrl.finalLogo.value.isEmpty)) {
                    //           //   guruvaniCtrl.finalLogo.value = "";
                    //           // }
                    //           // if (dashCtr.stateId.value == '') {
                    //           //   EasyLoading.showError('Select State First');
                    //           // } else
                    //
                    //           if (dashCtr.languageName.value == '') {
                    //             EasyLoading.showError('Select Language First');
                    //           } else if (tagController.fieldNameMapping.value
                    //               .contains('wishes')) {
                    //             if (guruvaniCtrl
                    //                     .selectedWishesPosition.value ==
                    //                 '') {
                    //               EasyLoading.showError(
                    //                   'Select Wishes Position First');
                    //             }
                    //           } else {
                    //             EasyLoading.showError('selectAll'.tr);
                    //           }
                    //           if (tagController.fieldNameMapping.value
                    //               .contains('political')) {
                    //             guruvaniCtrl.isFrame.value = false;
                    //             guruvaniCtrl.isWishes.value = false;
                    //             guruvaniCtrl.isPolitical.value = true;
                    //             guruvaniCtrl.other.value = false;
                    //           } else if (tagController.fieldNameMapping.value
                    //               .contains('wishes')) {
                    //             guruvaniCtrl.isFrame.value = false;
                    //             guruvaniCtrl.isWishes.value = true;
                    //             guruvaniCtrl.isPolitical.value = false;
                    //             guruvaniCtrl.other.value = false;
                    //           } else if (tagController.fieldNameMapping.value
                    //               .contains('frame')) {
                    //             guruvaniCtrl.isFrame.value = true;
                    //             guruvaniCtrl.isWishes.value = false;
                    //             guruvaniCtrl.isPolitical.value = false;
                    //             guruvaniCtrl.other.value = false;
                    //           } else {
                    //             guruvaniCtrl.isFrame.value = false;
                    //             guruvaniCtrl.isWishes.value = false;
                    //             guruvaniCtrl.isPolitical.value = false;
                    //             guruvaniCtrl.other.value = true;
                    //           }
                    //           DateTime startdateTime =
                    //               DateFormat('dd-MM-yyyy HH:mm').parse(
                    //                   guruvaniCtrl.startDate.value.text);
                    //
                    //           String formattedDate = DateFormat('dd-MM-yyyy')
                    //               .format(startdateTime);
                    //
                    //           guruvaniCtrl.startDateString.value =
                    //               formattedDate;
                    //
                    //           DateTime endDate = DateFormat('dd-MM-yyyy HH:mm')
                    //               .parse(guruvaniCtrl.endDate.value.text);
                    //           String formattedDate1 =
                    //               DateFormat('dd-MM-yyyy').format(endDate);
                    //
                    //           guruvaniCtrl.endDateString.value =
                    //               formattedDate1;
                    //
                    //           String formattedTime =
                    //               DateFormat('hh:mm').format(startdateTime);
                    //           guruvaniCtrl.startTimeString.value =
                    //               formattedTime;
                    //
                    //           String formattedTime1 =
                    //               DateFormat('HH:mm').format(endDate);
                    //           guruvaniCtrl.endTimeString.value =
                    //               formattedTime1;
                    //           if (guruvaniCtrl.titleController.value.text.isNotEmpty &&
                    //               guruvaniCtrl
                    //                   .colorController.value.text.isNotEmpty &&
                    //               guruvaniCtrl.mainPostImage.value
                    //                   .toString()
                    //                   .isNotEmpty &&
                    //               guruvaniCtrl
                    //                   .selectedAlignment.value.isNotEmpty &&
                    //               guruvaniCtrl
                    //                   .selectedShape.value.isNotEmpty &&
                    //               tagController.idTag.value.isNotEmpty) {
                    //             // cardCreationCtrl.updateCard(widget.id.toString());
                    //           } else {
                    //             EasyLoading.showError('selectAll'.tr);
                    //           }
                    //         },
                    //       ),
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
