import 'package:file_picker/file_picker.dart';
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
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';

class AddDarshanScreen extends StatefulWidget {
  const AddDarshanScreen({super.key});

  @override
  State<AddDarshanScreen> createState() => _AddDarshanScreenState();
}

class _AddDarshanScreenState extends State<AddDarshanScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
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
                        darshanCtrl.darshanTitleCtrl.refresh();
                      },
                      maxLength: 50,
                      controller: darshanCtrl.darshanTitleCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),

                formPadding(),
                creationSubTitle(
                    "description".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        darshanCtrl.darshanDescCtrl.refresh();
                      },
                      maxLength: 50,
                      controller: darshanCtrl.darshanDescCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "description".tr,
                    )),
                formPadding(),
                sanatanGodSelector(context),
                formPadding(),

                /// IMAGE SETTINGS BOX
                Obx(() {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      creationSubTitle(
                        "Upload".tr,
                        GestureDetector(
                          onTap: () async {
                            await FilePicker.platform
                                .pickFiles(
                                  type: FileType.custom,
                                  allowedExtensions: ['png'],
                                  allowMultiple: false,
                                )
                                .then((value) =>
                                    creationImageUploadCtrl.uploadToFirebase(
                                        value!.files.first.bytes!));
                          },
                          child: Container(
                            color: Colors.white,
                            height: 220,
                            width: 220,
                            child: postController.mainPostImage.value == ""
                                ? Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                        border: Border.all(
                                            width: 0.5, color: Colors.grey)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            "assets/images/imagePlaceholder.png",
                                            height: Get.height * 0.16,
                                            fit: BoxFit.fill,
                                          ),
                                          const SizedBox(height: 15),
                                          Flexible(
                                            child: Text(
                                              "uploadPost".tr,
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                          ),
                                          Flexible(
                                            child: Text(
                                              "acceptsJpgPng".tr,
                                              style: GoogleFonts.poppins(
                                                fontSize: 10,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                : Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          postController.mainPostImage.value,
                                          height: 200,
                                          width: 220,
                                          fit: BoxFit.cover,
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Center(
                                              child: Icon(
                                                Icons.image,
                                                size: 75,
                                                color: AppColors.teal50,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      Positioned(
                                        top: -8,
                                        right: -8,
                                        child: IconButton(
                                          onPressed: () {
                                            creationImageUploadCtrl
                                                .removeImage();
                                          },
                                          icon: Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    width: 1,
                                                    color: AppColors.teal50),
                                                shape: BoxShape.circle,
                                                color: AppColors.primaryColor),
                                            child: Center(
                                              child: Icon(
                                                Icons.close,
                                                color: AppColors.whiteCard,
                                                size: 12,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  );
                }),
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
                          if (darshanCtrl.darshanTitleCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter title");
                            return;
                          } else if (darshanCtrl
                              .darshanDescCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter Description");
                            return;
                          } else if (postController.mainPostImage.value == "") {
                            EasyLoading.showError("Select Image");
                            return;
                          } else {
                            darshanCtrl.createDarshan();
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
