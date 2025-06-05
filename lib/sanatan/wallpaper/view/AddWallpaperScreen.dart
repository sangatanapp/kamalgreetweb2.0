import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanPostTypeSelector.dart';
import '../../../Utils/internet/ConnectivityController.dart';


class AddWallpaperScreen extends StatefulWidget {
  final String? id;

  const AddWallpaperScreen({super.key, this.id});

  @override
  State<AddWallpaperScreen> createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  @override
  void initState() {
    postController.cropRatio.value = "1:1";
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () {
          if (connectivityController.connectionType == MConnectivityResult.wifi ||
              connectivityController.connectionType == MConnectivityResult.mobile) {
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
                        wallpaperCtrl.wallpaperTitleCtrl.refresh();
                      },
                      maxLength: 50,
                      controller: wallpaperCtrl.wallpaperTitleCtrl.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
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
                    isPhoto: postController.getPostType(),
                    isFromPoojaWallpaper: true),
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
                          if (wallpaperCtrl
                              .wallpaperTitleCtrl.value.text.isEmpty) {
                            EasyLoading.showError("Enter title");
                            return;
                          }
                          if (postController.mainPostImage.value == "") {
                            EasyLoading.showError("Select Image");
                            return;
                          }
                          wallpaperCtrl.createWallpaper();
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
