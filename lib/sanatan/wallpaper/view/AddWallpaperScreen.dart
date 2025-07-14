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
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/PostImageBox.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodSelector.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanPostTypeSelector.dart';
import '../../../Utils/values/AppConstants.dart';

final controller = Get.put(ConnectivityController());

class AddWallpaperScreen extends StatefulWidget {
  final String? id;

  const AddWallpaperScreen({super.key, this.id});

  @override
  State<AddWallpaperScreen> createState() => _AddWallpaperScreenState();
}

class _AddWallpaperScreenState extends State<AddWallpaperScreen> {
  @override
  void initState() {
    imageVideoMainCtrl.cropRatio.value = "1:1";
    super.initState();
  }

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
                  padding: EdgeInsets.symmetric(horizontal: 0),
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              /// POST TITLE
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.35,
                    child: Column(
                      children: [
                        creationSubTitle(
                            "title".tr,
                            DynamicTextfield(
                              onChange: (value) {
                                wallpaperCtrl.wallpaperTitleCtrl.refresh();
                              },
                              maxLength: AppConstants.maxtitleLength,
                              controller:
                                  wallpaperCtrl.wallpaperTitleCtrl.value,
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
                      ],
                    ),
                  ),

                  /// IMAGE SETTINGS BOX
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.55,
                    child: postImageBox(
                        context: context,
                        isPhoto: sanatanDashboardCtrl.getPostType(),
                        isFromPoojaWallpaper: true),
                  ),
                ],
              ),
              formPaddingPlus(),

              /// CANCEL & SUBMIT BUTTON
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                      Get.back();
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
                        if (wallpaperCtrl
                            .wallpaperTitleCtrl.value.text.isEmpty) {
                          EasyLoading.showError("Enter title");
                          return;
                        }
                        if (imageVideoMainCtrl.mainPostImage.value == "") {
                          EasyLoading.showError("Select Image");
                          return;
                        }
                        wallpaperCtrl.createWallpaper();
                      })
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
