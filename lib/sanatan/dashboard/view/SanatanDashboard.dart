import 'package:dotted_border/dotted_border.dart';
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
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/GreetingsCard.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/sanatan/Wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/Wallpaper/viewmodel/WallpaperViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/data/model/DarshanModel.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/view/AddDarshanScreen.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/viewmodel/DarshanViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/darshan/widgets/DarshanListWidget.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/widegt/SanatanOngoingUpcoming.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/widegt/SanatanPostWidget.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/view/AartiCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/aarti/widget/AartiList.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/view/ChaleesaCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/widget/ChaleesaList.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/view/MantraCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/viewmodel/SanatanDashboardViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/viewmodel/MantraCreationViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/mantra/widget/MantraList.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaDashboard.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/view/RingtoneCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/viewmodel/RingtoneCreationViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/ringtone/widget/RingtoneList.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/view/StotraCreationScreen.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/stotra/widget/StotraList.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/widgets/WallpaperList.dart';

import 'package:kamal_greet_web_2/sanatan/widgets/SanatanGodDrawer.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/SangrahModuleSelector.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/sanatanModuleSelector.dart';
import 'package:shimmer/shimmer.dart';

import '../viewmodel/SanatanGodViewModel.dart';
import 'SanatanCreationScreen.dart';

final SanatanGodViewModel sanatanGodCtrl = Get.put(SanatanGodViewModel());
final MantraViewModel mantraCtrl = Get.put(MantraViewModel());
final RingtoneViewModel ringtoneCtrl = Get.put(RingtoneViewModel());
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
  final controller = Get.put(ConnectivityController());
  double sidebarPadding = 15;
  double sideButtonsRadius = 100;
  double sideButtonsTextSize = 16;
  FontWeight sideButtonWieght = FontWeight.w500;

  @override
  void initState() {
    sanatanGodCtrl.getGodList();
    sanatanDashboardCtrl.getSanatanPost();
    sanatanDashboardCtrl.filterType.value = "ONGOING";
    sanatanDashboardCtrl.filterType.refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
      return Obx(
        () => controller.connectionType == MConnectivityResult.wifi ||
                controller.connectionType == MConnectivityResult.mobile
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
                                        Get.to(() => PoojaDashboard());
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
                                sanatanDashboardCtrl.selectedModule.value == 2
                                    ? sangrahModuleSelector()
                                    : const SizedBox.shrink(),

                                Obx(
                                  () => Padding(
                                    padding: const EdgeInsets.only(right: 80),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        sanatanDashboardCtrl
                                                    .selectedModule.value ==
                                                0
                                            ? sanatanOngoingUpcomingTabs(
                                                isMobile: isMobile,
                                                onPress: () {
                                                  sanatanDashboardCtrl
                                                      .toggleOngoingFilter(
                                                          "ONGOING");
                                                  try {
                                                    sanatanDashboardCtrl
                                                        .getSanatanPost();
                                                    sanatanDashboardCtrl
                                                        .scrollController
                                                        .jumpTo(0);
                                                  } catch (e) {}
                                                },
                                                tabName: "ONGOING",
                                              )
                                            : const SizedBox.shrink(),
                                        sanatanDashboardCtrl
                                                    .selectedModule.value ==
                                                0
                                            ? sanatanOngoingUpcomingTabs(
                                                isMobile: isMobile,
                                                onPress: () {
                                                  sanatanDashboardCtrl
                                                      .toggleOngoingFilter(
                                                          "UPCOMING");
                                                  try {
                                                    sanatanDashboardCtrl
                                                        .getSanatanPost();
                                                    sanatanDashboardCtrl
                                                        .scrollController
                                                        .jumpTo(0);
                                                  } catch (e) {}
                                                },
                                                tabName: "UPCOMING",
                                              )
                                            : const SizedBox.shrink(),
                                        SizedBox(width: 20),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: DynamicButton(
                                              leadingIcon: Icons.add,
                                              showLeading: true,
                                              radius: sideButtonsRadius,
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              width: isMobile ? 80 : 215,
                                              text: sanatanDashboardCtrl
                                                          .selectedModule
                                                          .value ==
                                                      2
                                                  ? 'Add ${mantraCtrl.sangrahModuleName[mantraCtrl.sangrahSelectedModule.value]}'
                                                  : 'Add ${sanatanDashboardCtrl.moduleName[sanatanDashboardCtrl.selectedModule.value]}',
                                              boldness: sideButtonWieght,
                                              height: isMobile ? 26 : 46,
                                              textSize: isMobile
                                                  ? 8
                                                  : sideButtonsTextSize,
                                              onTap: () async {
                                                sanatanCreationCtrl
                                                    .godSelectorController
                                                    .clear();
                                                postController.cropRatio.value =
                                                    "1:1";
                                                postController.startDate.value
                                                    .clear();
                                                postController.endDate.value
                                                    .clear();
                                                postController
                                                    .mainPostImage.value = "";
                                                postController.videoFirebaseUrl
                                                    .value = "";
                                                postController.videoFirebaseUrl
                                                    .refresh();
                                                postController.videoFirebaseUrl
                                                    .refresh();
                                                postController.cropRatio
                                                    .refresh();
                                                postController.mainPostImage
                                                    .refresh();
                                                postController
                                                    .sharingContent.value
                                                    .clear();
                                                postController
                                                    .titleController.value
                                                    .clear();

                                                /// NEW CREATION SCREEN
                                                if (sanatanDashboardCtrl
                                                        .selectedModule.value ==
                                                    1) {
                                                  wallpaperCtrl
                                                      .wallpaperTitleCtrl.value
                                                      .clear();
                                                  postController
                                                      .mainPostImage.value = "";
                                                  postController.mainPostImage
                                                      .refresh();
                                                  Get.to(() =>
                                                      const AddWallpaperScreen());
                                                } else if (sanatanDashboardCtrl
                                                        .selectedModule.value ==
                                                    3) {
                                                  darshanCtrl
                                                      .darshanTitleCtrl.value
                                                      .clear();
                                                  darshanCtrl
                                                      .darshanDescCtrl.value
                                                      .clear();
                                                  darshanCtrl.isPremium.value =
                                                      false;
                                                  postController
                                                      .mainPostImage.value = "";
                                                  postController.mainPostImage
                                                      .refresh();
                                                  Get.to(() =>
                                                      const AddDarshanScreen());
                                                } else if (sanatanDashboardCtrl
                                                        .selectedModule.value ==
                                                    2) {
                                                  if (mantraCtrl
                                                          .sangrahSelectedModule
                                                          .value ==
                                                      1) {
                                                    aartiCtrl.aartiTitleTextCtrl
                                                        .value
                                                        .clear();
                                                    aartiCtrl
                                                        .aartiDescTextCtrl.value
                                                        .clear();
                                                    Get.to(() =>
                                                        const AartiCreationScreen());
                                                  }
                                                  if (mantraCtrl
                                                          .sangrahSelectedModule
                                                          .value ==
                                                      0) {
                                                    mantraCtrl
                                                        .mantraTitleCtrl.value
                                                        .clear();
                                                    mantraCtrl
                                                        .mantraDescCtrl.value
                                                        .clear();
                                                    mantraCtrl
                                                        .firebaseAudioUrl = "";
                                                    Get.to(() =>
                                                        const AddMantraScreen());
                                                  }

                                                  if (mantraCtrl
                                                          .sangrahSelectedModule
                                                          .value ==
                                                      2) {
                                                    chaleesaCtrl
                                                        .chaleesaTitleTextCtrl
                                                        .value
                                                        .clear();
                                                    chaleesaCtrl
                                                        .chaleesaDescTextCtrl
                                                        .value
                                                        .clear();
                                                    Get.to(() =>
                                                        const ChaleesaCreationScreen());
                                                  }
                                                  if (mantraCtrl
                                                          .sangrahSelectedModule
                                                          .value ==
                                                      3) {
                                                    stotraCtrl
                                                        .stotraTitleTextCtrl
                                                        .value
                                                        .clear();
                                                    stotraCtrl
                                                        .stotraDescTextCtrl
                                                        .value
                                                        .clear();
                                                    Get.to(() =>
                                                        const StotraCreationScreen());
                                                  }
                                                  if (mantraCtrl
                                                          .sangrahSelectedModule
                                                          .value ==
                                                      4) {
                                                    ringtoneCtrl
                                                        .ringtoneTitleCtrl.value
                                                        .clear();
                                                    ringtoneCtrl
                                                        .ringtoneDescCtrl.value
                                                        .clear();
                                                    ringtoneCtrl
                                                        .firebaseAudioUrl
                                                        .value = "";
                                                    ringtoneCtrl
                                                        .firebaseAudioUrl
                                                        .refresh();
                                                    Get.to(() =>
                                                        const RingtoneCreationScreen());
                                                  }
                                                } else {
                                                  Get.to(
                                                      const SanatanCreationScreen());
                                                }
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
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
                                            3
                                        ? Obx(() {
                                            switch (darshanCtrl
                                                .rxDarshanStatus.value) {
                                              case Status.INITIAL:
                                                return const SizedBox.shrink();
                                              case Status.COMPLETED:
                                                return Flexible(
                                                    child: darshanListWidget(
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
                                                    2
                                                ? Obx(() {
                                                    if (mantraCtrl
                                                            .sangrahSelectedModule
                                                            .value ==
                                                        0) {
                                                      switch (mantraCtrl
                                                          .rxMantraStatus
                                                          .value) {
                                                        case Status.INITIAL:
                                                          return const SizedBox
                                                              .shrink();
                                                        case Status.COMPLETED:
                                                          return Flexible(
                                                              child:
                                                                  mantraListWidget(
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
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                title(
                                                                    'error'.tr,
                                                                    isMobile),
                                                              ],
                                                            ),
                                                          );
                                                      }
                                                    } else if (mantraCtrl
                                                            .sangrahSelectedModule
                                                            .value ==
                                                        1) {
                                                      switch (aartiCtrl
                                                          .rxAartiStatus
                                                          .value) {
                                                        case Status.INITIAL:
                                                          return const SizedBox
                                                              .shrink();
                                                        case Status.COMPLETED:
                                                          return Flexible(
                                                              child:
                                                                  aartiListWidget(
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
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                title(
                                                                    'error'.tr,
                                                                    isMobile),
                                                              ],
                                                            ),
                                                          );
                                                      }
                                                    } else if (mantraCtrl
                                                            .sangrahSelectedModule
                                                            .value ==
                                                        2) {
                                                      switch (chaleesaCtrl
                                                          .rxChaleesaStatus
                                                          .value) {
                                                        case Status.INITIAL:
                                                          return const SizedBox
                                                              .shrink();
                                                        case Status.COMPLETED:
                                                          return Flexible(
                                                              child:
                                                                  chaleesaListWidget(
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
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                title(
                                                                    'error'.tr,
                                                                    isMobile),
                                                              ],
                                                            ),
                                                          );
                                                      }
                                                    } else if (mantraCtrl
                                                            .sangrahSelectedModule
                                                            .value ==
                                                        3) {
                                                      switch (stotraCtrl
                                                          .rxStotraStatus
                                                          .value) {
                                                        case Status.INITIAL:
                                                          return const SizedBox
                                                              .shrink();
                                                        case Status.COMPLETED:
                                                          return Flexible(
                                                              child:
                                                                  stotraListWidget(
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
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                title(
                                                                    'error'.tr,
                                                                    isMobile),
                                                              ],
                                                            ),
                                                          );
                                                      }
                                                    } else if (mantraCtrl
                                                            .sangrahSelectedModule
                                                            .value ==
                                                        4) {
                                                      switch (ringtoneCtrl
                                                          .rxRingtoneStatus
                                                          .value) {
                                                        case Status.INITIAL:
                                                          return const SizedBox
                                                              .shrink();
                                                        case Status.COMPLETED:
                                                          return Flexible(
                                                              child:
                                                                  ringtoneListWidget(
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
                                                                      width:
                                                                          200,
                                                                      height:
                                                                          200,
                                                                      fit: BoxFit
                                                                          .fill),
                                                                ),
                                                                const SizedBox(
                                                                  height: 10,
                                                                ),
                                                                title(
                                                                    'error'.tr,
                                                                    isMobile),
                                                              ],
                                                            ),
                                                          );
                                                      }
                                                    } else {
                                                      return const SizedBox();
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

  void showStateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0), // Curved border
          ),
          child: Container(
            width: Get.width * 0.2,
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Ensure dialog size is dynamic
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Select State',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () =>
                          Navigator.pop(context), // Close the dialog
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: dashCtr.stateList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(
                          dashCtr.stateList[index].state,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.black),
                        ),
                        onTap: () {
                          dashCtr.stateId.value =
                              dashCtr.stateList[index].stateId;
                          dashCtr.stateName.value =
                              dashCtr.stateList[index].state;

                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> showTagDialogue(String id) {
    return showDialog<void>(
        context: context,
        builder: ((context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                width: 350,
                height: 280,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'addTagName'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: AppConstants.titleSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: DynamicTextfield(
                              height: 45,
                              hintText: 'enterName'.tr,
                              controller: tagCtr.tagNameController.value,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Obx(() {
                            if (tagCtr.isLoadingTag.value) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey.withOpacity(0.2),
                                highlightColor: Colors.grey.withOpacity(0.1),
                                child: Container(
                                  height: 80,
                                  width: 80,
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFFFFA5A8),
                                        Color(0xFFFFE3F6),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12)),
                                  ),
                                  child: const Padding(
                                    padding: EdgeInsets.all(15),
                                    child: SizedBox(
                                      height: 80,
                                      width: 80,
                                      child: Text('jhghjkl'),
                                    ),
                                  ),
                                ),
                              );
                            } else {
                              return GestureDetector(
                                onTap: () {
                                  tagCtr.pickTagImageFromGallery();
                                },
                                child: Container(
                                  color: Colors.white,
                                  height: 80,
                                  width: 80,
                                  child: tagCtr.tagPhotos.value == ""
                                      ? DottedBorder(
                                          borderType: BorderType.RRect,
                                          radius: const Radius.circular(20),
                                          color: Colors.grey,
                                          strokeWidth: 1,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.add_a_photo,
                                                  color: Colors.black,
                                                  size: 30,
                                                ),
                                                const SizedBox(height: 5),
                                                Text(
                                                  'uploadIcon'.tr,
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(20)),
                                              child: Image.network(
                                                tagCtr.tagPhotos.value,
                                                height: 80,
                                                width: 80,
                                                fit: BoxFit.cover,
                                                errorBuilder: (context, error,
                                                    stackTrace) {
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
                                                  tagCtr.removeTagImage();
                                                },
                                                icon: Container(
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                      width: 0.5,
                                                      color: AppColors.teal50,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color:
                                                        const Color(0xFFDC7AA9),
                                                  ),
                                                  child: Center(
                                                    child: Icon(
                                                      Icons.close,
                                                      color:
                                                          AppColors.whiteCard,
                                                      size: 10,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              );
                            }
                          }),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DynamicButton(
                                backgroundColor: AppColors.pink,
                                text: "cancel".tr,
                                width: 100,
                                height: 30,
                                textSize: 14,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              id == ''
                                  ? DynamicButton(
                                      text: 'submit'.tr,
                                      width: 100,
                                      height: 30,
                                      textSize: 14,
                                      onTap: () {
                                        tagCtr.createTag();
                                        Navigator.pop(context);
                                      },
                                    )
                                  : DynamicButton(
                                      text: 'update'.tr,
                                      width: 100,
                                      height: 30,
                                      textSize: 14,
                                      onTap: () {},
                                    ),
                            ],
                          ),
                        ])),
              ),
            ),
          );
        }));
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
