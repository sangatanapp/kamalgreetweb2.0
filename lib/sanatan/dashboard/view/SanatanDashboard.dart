import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
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
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
                                width: MediaQuery.of(context).size.width * 0.17,
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
                                        // dashCtr.isGuruVaniDrawer.value = true;
                                        // dashCtr.isGuruVaniDrawer.refresh();
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
                                        context.go("/pooja/dashboard");
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
                                                context: context,
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
                                                context: context,
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
                                                imageVideoMainCtrl
                                                    .cropRatio.value = "1:1";
                                                sanatanCreationCtrl
                                                    .startDate.text = "";
                                                sanatanCreationCtrl
                                                    .endDate.text = "";
                                                imageVideoMainCtrl
                                                    .mainPostImage.value = "";
                                                imageVideoMainCtrl
                                                    .videoFirebaseUrl
                                                    .value = "";
                                                imageVideoMainCtrl
                                                    .videoFirebaseUrl
                                                    .refresh();
                                                imageVideoMainCtrl
                                                    .videoFirebaseUrl
                                                    .refresh();
                                                imageVideoMainCtrl.cropRatio
                                                    .refresh();
                                                imageVideoMainCtrl.mainPostImage
                                                    .refresh();
                                                sanatanCreationCtrl
                                                    .sharingContent.value
                                                    .clear();
                                                sanatanCreationCtrl
                                                    .titleController.value
                                                    .clear();

                                                /// NEW CREATION SCREEN
                                                if (sanatanDashboardCtrl
                                                        .selectedModule.value ==
                                                    1) {
                                                  wallpaperCtrl
                                                      .wallpaperTitleCtrl.value
                                                      .clear();
                                                  imageVideoMainCtrl
                                                      .mainPostImage.value = "";
                                                  imageVideoMainCtrl
                                                      .mainPostImage
                                                      .refresh();
                                                  context.go(
                                                      '/sanatan/wallpaper/creation');
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
                                                  imageVideoMainCtrl
                                                      .mainPostImage.value = "";
                                                  imageVideoMainCtrl
                                                      .mainPostImage
                                                      .refresh();
                                                  context.go(
                                                      '/sanatan/darshan/creation');
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
                                                    context.go(
                                                        '/sanatan/aarti/creation');
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
                                                    context.go(
                                                        '/sanatan/mantra/creation');
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
                                                    context.go(
                                                        '/sanatan/chaleesa/creation');
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
                                                    context.go(
                                                        '/sanatan/stotra/creation');
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
                                                    context.go(
                                                        '/sanatan/ringtone/creation');
                                                  }
                                                } else {
                                                  context
                                                      .go('/sanatan/creation');
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
