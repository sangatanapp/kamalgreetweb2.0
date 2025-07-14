import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';
import 'package:kamal_greet_web_2/webp/viewmodels/image_viewmodel.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Utils/values/AppColors.dart';
import '../../Utils/ImageVideoUploader/viewmodel/CreationImageUploadViewModel.dart';

final CreationImageUploadViewModel creationImageUploadCtrl =
    Get.put(CreationImageUploadViewModel());

final ImageConverterViewModel imageConverterViewModel =
    Get.put(ImageConverterViewModel());

Widget postImageBox(
    {required BuildContext context,
    required bool isPhoto,
    bool isFromPoojaWallpaper = false}) {
  Widget buildOption(String option) {

    return Row(
      children: [
        Obx(() => OutlinedButton(
              onPressed: () {
                imageVideoMainCtrl.selectOption(option);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor:
                imageVideoMainCtrl.selectedAlignment.value == option
                        ? AppColors.positionButton
                        : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    color: imageVideoMainCtrl.selectedAlignment.value == option
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )),
      ],
    );
  }

  Widget buildVideoAvtarShapeOption(String option) {

    return Row(
      children: [
        Obx(() => OutlinedButton(
              onPressed: () {
                imageVideoMainCtrl.selectVideoAvtarShapeOption(option);
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(color: Colors.grey.shade200),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                backgroundColor: imageVideoMainCtrl.selectedShape.value == option
                    ? AppColors.positionButton
                    : Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                child: Text(
                  option,
                  style: GoogleFonts.poppins(
                    color: imageVideoMainCtrl.selectedShape.value == option
                        ? Colors.white
                        : Colors.black,
                  ),
                ),
              ),
            )),
      ],
    );
  }


  Widget creationSubTitle(String title, Widget child, bool hasPadding) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: EdgeInsets.only(left: hasPadding ? 8.0 : 0),
          child: child,
        )
      ],
    );
  }

  Widget ratioChip(String ratio) {
    bool isVideo = !isPhoto;
    return Padding(
      padding: const EdgeInsets.only(right: 5),
      child: OutlinedButton(
        onPressed: () {
          imageVideoMainCtrl.cropRatio.value = ratio;
        },
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Colors.grey.shade200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: isVideo
              ? AppColors.positionButton
              : (imageVideoMainCtrl.cropRatio.value == ratio
                  ? AppColors.positionButton
                  : Colors.white),
          minimumSize: Size(60, 30),
        ),
        child: Text(
          ratio,
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.width > 600 ? 14 : 10,
            color: isVideo
                ? Colors.white
                : (imageVideoMainCtrl.cropRatio.value == ratio
                    ? Colors.white
                    : Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget ratioWidget(bool isPhoto) {
    if (isPhoto) {
      return Visibility(
        // visible: sanatanDashboardCtrl.categorySelected.value != 'video',
        visible: false,
        child: creationSubTitle(
            'selectRatio'.tr,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ratioChip("1:1"),
                ratioChip("16:9"),
                ratioChip("3:2"),
                ratioChip("4:3"),
                ratioChip("4:5"),
              ],
            ),
            false),
      );
    } else {
      return Visibility(
        visible: true,
        child: creationSubTitle('selectRatio'.tr,
            ratioChip(imageVideoMainCtrl.videoRatio.value), false),
      );
    }
  }

  /// POST IMAGE BOX
  return Container(
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          /// IMAGE BOX
          Obx(() {
            if (imageVideoMainCtrl.isLoading.value) {
              return Flexible(
                flex: 1,
                child: Shimmer.fromColors(
                  baseColor: Colors.grey.withOpacity(0.2),
                  highlightColor: Colors.grey.withOpacity(0.1),
                  child: Container(
                    height: 200,
                    width: 220,
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFFA5A8),
                            Color(0xFFFFE3F6),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(12))),
                    child: const Padding(
                      padding: EdgeInsets.all(15),
                      child: SizedBox(
                          height: 150, width: 150, child: Text('jhghjkl')),
                    ),
                  ),
                ),
              );
            } else {
              return Flexible(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    creationSubTitle(
                        "uploadPost".tr,
                        GestureDetector(
                          onTap: () {

                            if (sanatanDashboardCtrl.categorySelected.value ==
                                'video') {
                              // creationVideoUploadCtrl.pickVideoFromGallery();
                            } else {
                              imageVideoMainCtrl.cropRatio.value == ""
                                  ? EasyLoading.showError("selectRatio".tr)
                                  : imageConverterViewModel.pickAndConvertImage(
                                      isFromPoojaWallpaper:
                                          isFromPoojaWallpaper);
                            }
                          },
                          child: Container(
                            color: Colors.white,
                            height: 220,
                            width: 220,
                            child: imageVideoMainCtrl.mainPostImage.value == ""
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
                                            height: MediaQuery.of(context).size.height * 0.16,
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
                                          imageVideoMainCtrl.mainPostImage.value,
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
                        false),
                    const SizedBox(height: 10),
                  ],
                ),
              );
            }
          }),

          /// IMAGE SETTINGS
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// AVATAR POSITION
                Visibility(
                  visible: sanatanDashboardCtrl.categorySelected.value != 'video',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: creationSubTitle(
                        'setAvatarPosition'.tr,
                        Row(
                          children: [
                            buildOption('bottomLeft'),
                            const SizedBox(
                              width: 20,
                            ),
                            buildOption('bottomRight'),
                          ],
                        ),
                        false),
                  ),
                ),

                /// video avtar position
                Visibility(
                  visible: sanatanDashboardCtrl.categorySelected.value == 'video',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: creationSubTitle(
                        'setAvatarPosition'.tr,
                        Row(
                          children: [
                            buildOption('bottomLeft'),
                            const SizedBox(
                              width: 20,
                            ),
                            buildOption('center'),
                            const SizedBox(
                              width: 20,
                            ),
                            buildOption('bottomRight'),
                          ],
                        ),
                        false),
                  ),
                ),

                /// video avtar position
                Visibility(
                  visible: sanatanDashboardCtrl.categorySelected.value == 'video',
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: creationSubTitle(
                        'selectAvatarShape'.tr,
                        Row(
                          children: [
                            buildVideoAvtarShapeOption('square'),
                            const SizedBox(
                              width: 20,
                            ),
                            buildVideoAvtarShapeOption('circle'),
                          ],
                        ),
                        false),
                  ),
                ),

                /// RATIO SELECTOR
                ratioWidget(isPhoto),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
