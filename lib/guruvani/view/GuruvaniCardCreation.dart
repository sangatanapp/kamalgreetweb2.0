import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicAppbar.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/guruvani/widgets/GuruSelector.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';

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
                      padding: EdgeInsets.symmetric(
                          horizontal: Get.width * 0.16),
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
          () =>
          Container(
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
                                  // await selectStartDateAndTime(context);
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
                                  awaut.selectEndDateAndTime(context);
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
                    Obx(
                          () =>
                          creationSubTitle(
                              "Select Guru", guruSelector(context)),
                    ),
                    formPadding(),

                    // /// IMAGE SETTINGS BOX
                    // postImageBox(
                    //     context: context, isPhoto: postController.getPostType()),
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
                              postController.checkFields();
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
                        //           postController.checkFields();
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
                        //           //     (postController.finalLogo.value.isEmpty)) {
                        //           //   postController.finalLogo.value = "";
                        //           // }
                        //           // if (dashCtr.stateId.value == '') {
                        //           //   EasyLoading.showError('Select State First');
                        //           // } else
                        //
                        //           if (dashCtr.languageName.value == '') {
                        //             EasyLoading.showError('Select Language First');
                        //           } else if (tagController.fieldNameMapping.value
                        //               .contains('wishes')) {
                        //             if (postController
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
                        //             postController.isFrame.value = false;
                        //             postController.isWishes.value = false;
                        //             postController.isPolitical.value = true;
                        //             postController.other.value = false;
                        //           } else if (tagController.fieldNameMapping.value
                        //               .contains('wishes')) {
                        //             postController.isFrame.value = false;
                        //             postController.isWishes.value = true;
                        //             postController.isPolitical.value = false;
                        //             postController.other.value = false;
                        //           } else if (tagController.fieldNameMapping.value
                        //               .contains('frame')) {
                        //             postController.isFrame.value = true;
                        //             postController.isWishes.value = false;
                        //             postController.isPolitical.value = false;
                        //             postController.other.value = false;
                        //           } else {
                        //             postController.isFrame.value = false;
                        //             postController.isWishes.value = false;
                        //             postController.isPolitical.value = false;
                        //             postController.other.value = true;
                        //           }
                        //           DateTime startdateTime =
                        //               DateFormat('dd-MM-yyyy HH:mm').parse(
                        //                   postController.startDate.value.text);
                        //
                        //           String formattedDate = DateFormat('dd-MM-yyyy')
                        //               .format(startdateTime);
                        //
                        //           postController.startDateString.value =
                        //               formattedDate;
                        //
                        //           DateTime endDate = DateFormat('dd-MM-yyyy HH:mm')
                        //               .parse(postController.endDate.value.text);
                        //           String formattedDate1 =
                        //               DateFormat('dd-MM-yyyy').format(endDate);
                        //
                        //           postController.endDateString.value =
                        //               formattedDate1;
                        //
                        //           String formattedTime =
                        //               DateFormat('hh:mm').format(startdateTime);
                        //           postController.startTimeString.value =
                        //               formattedTime;
                        //
                        //           String formattedTime1 =
                        //               DateFormat('HH:mm').format(endDate);
                        //           postController.endTimeString.value =
                        //               formattedTime1;
                        //           if (postController.titleController.value.text.isNotEmpty &&
                        //               postController
                        //                   .colorController.value.text.isNotEmpty &&
                        //               postController.mainPostImage.value
                        //                   .toString()
                        //                   .isNotEmpty &&
                        //               postController
                        //                   .selectedAlignment.value.isNotEmpty &&
                        //               postController
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
