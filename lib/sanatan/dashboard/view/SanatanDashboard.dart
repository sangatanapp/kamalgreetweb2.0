import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';

import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/view/AddDarshanScreen.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/viewmodel/DarshanViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/widgets/DarshanListWidget.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/viewmodel/SanatanDashboardViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/widegt/SanatanPostWidget.dart';
import 'package:kamal_greet_web_2/sanatan/mantra/view/MantraCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/mantra/viewmodel/MantraCreationViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/mantra/widget/MantraList.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/viewmodel/WallpaperViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/widgets/WallpaperList.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodDrawer.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/sanatanModuleSelector.dart';
import 'package:shimmer/shimmer.dart';

import '../viewmodel/SanatanGodViewModel.dart';
import 'SanatanCreationScreen.dart';

final SanatanGodViewModel sanatanGodCtrl = Get.put(SanatanGodViewModel());
final MantraViewModel mantraCtrl = Get.put(MantraViewModel());
final SanatanDashboardViewModel sanatanDashboardCtrl =
    Get.put(SanatanDashboardViewModel());
final WallpaperViewModel wallpaperCtrl = Get.put(WallpaperViewModel());
final DarshanViewModel darshanCtrl = Get.put(DarshanViewModel());

class SanatanDashboardScreen extends StatefulWidget {
  const SanatanDashboardScreen({super.key});

  @override
  State<SanatanDashboardScreen> createState() => _SanatanDashboardScreenState();
}

class _SanatanDashboardScreenState extends State<SanatanDashboardScreen> {
  final postController = Get.put(CreationViewModel());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final SubCategoryViewModel tagCtr = Get.find();
  Uint8List? selectedImage;
  double sidebarPadding = 15;
  double sideButtonsRadius = 100;
  double sideButtonsTextSize = 16;
  FontWeight sideButtonWieght = FontWeight.w500;

  @override
  void initState() {
    sanatanGodCtrl.getGodList();
    sanatanDashboardCtrl.getSanatanPost();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
      return Obx(
        () => connectivityController.connectionType == MConnectivityResult.wifi ||
            connectivityController.connectionType == MConnectivityResult.mobile
            ? PopScope(
                child: Scaffold(
                  appBar: AppBar(
                    centerTitle: true,
                    title: Text(
                      "Sanatan",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  key: _scaffoldKey,
                  backgroundColor: AppColors.creationScreenBackground,
                  body: Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Align(
                      alignment: Alignment.center,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// HEADER BUTTONS
                          Visibility(
                            visible: true,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30),
                              child: Container(
                                width: Get.width * 0.17,
                                decoration:
                                    const BoxDecoration(color: Colors.white),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                        height: isMobile ? 5 : sidebarPadding),
                                    DynamicButton(
                                      radius: sideButtonsRadius,
                                      boldness: sideButtonWieght,
                                      backgroundColor: AppColors.yellowBg,
                                      width: isMobile ? 80 : 140,
                                      text: "View God",
                                      textColor: AppColors.yellowText,
                                      height: isMobile ? 26 : 36,
                                      textSize:
                                          isMobile ? 8 : sideButtonsTextSize,
                                      onTap: () {
                                        dashCtr.isGuruVaniDrawer.value = true;
                                        dashCtr.isGuruVaniDrawer.refresh();
                                        _scaffoldKey.currentState?.openDrawer();
                                      },
                                    ),
                                    SizedBox(
                                        height: isMobile ? 5 : sidebarPadding),
                                    DynamicButton(
                                      radius: sideButtonsRadius,
                                      boldness: sideButtonWieght,
                                      backgroundColor: AppColors.yellowBg,
                                      width: isMobile ? 80 : 140,
                                      text: "Pooja",
                                      textColor: AppColors.yellowText,
                                      height: isMobile ? 26 : 36,
                                      textSize:
                                          isMobile ? 8 : sideButtonsTextSize,
                                      onTap: () {
                                        Get.to(() => const PoojaDashboard());
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          /// LIST OF POSTS and BUTTONS
                          Expanded(
                            child: Column(
                              // crossAxisAlignment: CrossAxisAlignment.end,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(height: 20),
                                sanatanModuleSelector(isMobile: isMobile),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: DynamicButton(
                                      leadingIcon: Icons.add,
                                      showLeading: true,
                                      radius: sideButtonsRadius,
                                      backgroundColor: AppColors.primaryColor,
                                      width: isMobile ? 80 : 180,
                                      text:
                                          'Add ${sanatanDashboardCtrl.moduleName[sanatanDashboardCtrl.selectedModule.value]}'
                                              .tr,
                                      boldness: sideButtonWieght,
                                      height: isMobile ? 26 : 46,
                                      textSize:
                                          isMobile ? 8 : sideButtonsTextSize,
                                      onTap: () async {
                                        sanatanCreationCtrl
                                            .godSelectorController
                                            .clear();
                                        postController.cropRatio.value = "1:1";
                                        postController.startDate.value.clear();
                                        postController.endDate.value.clear();
                                        postController.mainPostImage.value = "";
                                        postController.videoFirebaseUrl.value =
                                            "";
                                        postController.videoFirebaseUrl
                                            .refresh();
                                        postController.videoFirebaseUrl
                                            .refresh();
                                        postController.cropRatio.refresh();
                                        postController.mainPostImage.refresh();
                                        postController.sharingContent.value
                                            .clear();
                                        postController.titleController.value
                                            .clear();

                                        /// NEW CREATION SCREEN
                                        if (sanatanDashboardCtrl
                                                .selectedModule.value ==
                                            1) {
                                          wallpaperCtrl.wallpaperTitleCtrl.value
                                              .clear();
                                          postController.mainPostImage.value =
                                              "";
                                          postController.mainPostImage
                                              .refresh();
                                          Get.to(
                                              () => const AddWallpaperScreen());
                                        } else if (sanatanDashboardCtrl
                                                .selectedModule.value ==
                                            3) {
                                          darshanCtrl.darshanTitleCtrl.value
                                              .clear();
                                          darshanCtrl.darshanDescCtrl.value
                                              .clear();
                                          postController.mainPostImage.value =
                                              "";
                                          postController.mainPostImage
                                              .refresh();
                                          Get.to(
                                              () => const AddDarshanScreen());
                                        } else if (sanatanDashboardCtrl
                                                .selectedModule.value ==
                                            2) {
                                          mantraCtrl.mantraTitleCtrl.value
                                              .clear();
                                          mantraCtrl.mantraDescCtrl.value
                                              .clear();
                                          mantraCtrl.firebaseAudioUrl = "";
                                          Get.to(() => const AddMantraScreen());
                                        } else {
                                          Get.to(const SanatanCreationScreen());
                                        }
                                      },
                                    ),
                                  ),
                                ),

                                /// LIST OF POSTS
                                sanatanDashboardCtrl.selectedModule.value == 1
                                    ? Obx(() {
                                        switch (wallpaperCtrl
                                            .rxSanatanWallpaperStatus.value) {
                                          case Status.INITIAL:
                                            return const SizedBox.shrink();
                                          case Status.COMPLETED:
                                            return Flexible(
                                                child: wallpaperListWidget(
                                                    isMobile));
                                          case Status.LOADING:
                                            return Flexible(
                                                child: shimmerCards());
                                          case Status.ERROR:
                                            return Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  SizedBox(
                                                    height: 200,
                                                    width: 200,
                                                    child: Image.asset(
                                                        'assets/images/error.png',
                                                        width: 200,
                                                        height: 200,
                                                        fit: BoxFit.fill),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  title('error'.tr, isMobile),
                                                ],
                                              ),
                                            );
                                        }
                                      })
                                    : sanatanDashboardCtrl
                                                .selectedModule.value ==
                                            2
                                        ? Obx(() {
                                            switch (mantraCtrl
                                                .rxMantraStatus.value) {
                                              case Status.INITIAL:
                                                return const SizedBox.shrink();
                                              case Status.COMPLETED:
                                                return Flexible(
                                                    child: mantraListWidget(
                                                        isMobile));
                                              case Status.LOADING:
                                                return Flexible(
                                                    child: shimmerCards());
                                              case Status.ERROR:
                                                return Center(
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        height: 200,
                                                        width: 200,
                                                        child: Image.asset(
                                                            'assets/images/error.png',
                                                            width: 200,
                                                            height: 200,
                                                            fit: BoxFit.fill),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),
                                                      title(
                                                          'error'.tr, isMobile),
                                                    ],
                                                  ),
                                                );
                                            }
                                          })
                                        : sanatanDashboardCtrl
                                                    .selectedModule.value ==
                                                3
                                            ? Obx(() {
                                                switch (darshanCtrl
                                                    .rxDarshanStatus.value) {
                                                  case Status.INITIAL:
                                                    return const SizedBox
                                                        .shrink();
                                                  case Status.COMPLETED:
                                                    return Flexible(
                                                        child:
                                                            darshanListWidget(
                                                                isMobile));
                                                  case Status.LOADING:
                                                    return Flexible(
                                                        child: shimmerCards());
                                                  case Status.ERROR:
                                                    return Center(
                                                      child: Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            height: 200,
                                                            width: 200,
                                                            child: Image.asset(
                                                                'assets/images/error.png',
                                                                width: 200,
                                                                height: 200,
                                                                fit: BoxFit
                                                                    .fill),
                                                          ),
                                                          const SizedBox(
                                                            height: 10,
                                                          ),
                                                          title('error'.tr,
                                                              isMobile),
                                                        ],
                                                      ),
                                                    );
                                                }
                                              })
                                            : sanatanDashboardCtrl
                                                        .selectedModule.value ==
                                                    0
                                                ? Obx(() {
                                                    switch (sanatanDashboardCtrl
                                                        .rxSanatanPostStatus
                                                        .value) {
                                                      case Status.INITIAL:
                                                        return const SizedBox
                                                            .shrink();
                                                      case Status.COMPLETED:
                                                        return Flexible(
                                                            child:
                                                                sanatanpPostWidget(
                                                                    isMobile));
                                                      case Status.LOADING:
                                                        return Flexible(
                                                            child:
                                                                shimmerCards());
                                                      case Status.ERROR:
                                                        return Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              SizedBox(
                                                                height: 200,
                                                                width: 200,
                                                                child: Image.asset(
                                                                    'assets/images/error.png',
                                                                    width: 200,
                                                                    height: 200,
                                                                    fit: BoxFit
                                                                        .fill),
                                                              ),
                                                              const SizedBox(
                                                                height: 10,
                                                              ),
                                                              title('error'.tr,
                                                                  isMobile),
                                                            ],
                                                          ),
                                                        );
                                                    }
                                                  })
                                                : const SizedBox.shrink(),

                                const SizedBox(height: 30)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  drawer: SanatanGodDrawer(isMobile: isMobile),
                ),
              )
            : const ConnectivityWidget(),
      );
    });
  }

  Widget shimmerCards() {
    return Shimmer.fromColors(
      baseColor: Colors.grey.withOpacity(0.2),
      highlightColor: Colors.grey.withOpacity(0.1),
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            width: MediaQuery.of(context).size.width * 0.1,
            height: MediaQuery.of(context).size.height * 0.32,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              gradient: LinearGradient(
                colors: [
                  Color(0xFF86F6C7),
                  Color(0xFFEEFEFA),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget programListBuilder(bool isMobile) {
    final filteredList = dashCtr.listCards!.where((card) {
      try {
        final startDate =
            DateFormat('dd-MM-yy HH:mm').parse(card?.startDate ?? "");
        final now = DateTime.now();

        if (dashCtr.filterType.value == "ONGOING") {
          return startDate.isBefore(now) || startDate.isAtSameMomentAs(now);
        } else {
          return startDate.isAfter(now);
        }
      } catch (e) {
        print("Error parsing date: $e");
        return false;
      }
    }).toList();
    if (filteredList.isEmpty) {
      return Center(
        child: Card(
          color: Colors.yellow.shade100,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.warning_amber_rounded,
                  size: 50,
                  color: Colors.orange.shade800,
                ),
                const SizedBox(height: 10),
                Text(
                  'No Data Available',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return ListView.builder(
      controller: dashCtr.scrollController,
      shrinkWrap: true,
      itemCount: filteredList.length,
      itemBuilder: ((context, index) {
        final card = filteredList[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Obx(() {
            if (dashCtr.rxRequestStatus.value == Status.LOADING) {
              return const CircularProgressIndicator(); // Show loading indicator
            }

            return GreetingsCard(
              isMobile: isMobile,
              startDate: card?.startDate ?? "",
              endDate: card?.endDate ?? "",
              createdAt: card?.createdAt ?? "",
              name: card?.title ?? "",
              tag: card?.tagList ?? [],
              postType: card?.postType,
              image: card?.postUrl ?? "",
              status: "ACTIVE",
              id: card?.id.toString() ?? '',
              index: index,
              sharedCount: card?.sharedCount ?? 0,
              downloadCount: card?.downloadCount ?? 0,
              isPosition: card?.avatarPostion ?? "",
              isShape: card?.avatarShape ?? "",
              isPinned: card?.isPinned ?? false,
            );
          }),
        );
      }),
    );
  }


  Widget title(String title, final isMobile) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: isMobile ? AppConstants.titleSize : AppConstants.titleSize2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
