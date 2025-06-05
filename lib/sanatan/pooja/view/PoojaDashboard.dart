import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/AddPoojaDetails.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/PoojaBookingList.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/viewmodel/PoojaDashboardViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/HelperListMaker.dart';
import 'package:shimmer/shimmer.dart';
import '../../../Utils/values/AppConstants.dart';

final PoojaDashboardViewModel poojaDashboardCtrl =
    Get.put(PoojaDashboardViewModel());

class PoojaDashboard extends StatefulWidget {
  const PoojaDashboard({super.key});

  @override
  State<PoojaDashboard> createState() => _PoojaDashboardState();
}

class _PoojaDashboardState extends State<PoojaDashboard> {
  @override
  void initState() {
    poojaDashboardCtrl.getPooja();
    poojaDashboardCtrl.getPoojaPricingDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sideButtonsRadius = 100;
    double sideButtonsTextSize = 16;
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
      return Obx(
        () => connectivityController.connectionType == MConnectivityResult.wifi ||
            connectivityController.connectionType == MConnectivityResult.mobile
            ? PopScope(
                child: Scaffold(
                  appBar: AppBar(
                    actions: [
                      TextButton(
                          onPressed: () =>
                              Get.to(() => const PoojaBookingList()),
                          child: const Text("Pooja Booking List"))
                    ],
                    leading: InkWell(
                        onTap: () => Get.back(),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black)),
                    centerTitle: true,
                    title: Text(
                      "Pooja",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: AppColors.creationScreenBackground,
                  body: Padding(
                    padding: const EdgeInsets.only(right: 30, top: 30),
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: DynamicButton(
                              radius: sideButtonsRadius,
                              boldness: FontWeight.w700,
                              backgroundColor: AppColors.pinkDark,
                              width: isMobile ? 80 : 180,
                              text: "Add Pooja",
                              textColor: Colors.red.shade500,
                              height: isMobile ? 26 : 46,
                              textSize: isMobile ? 8 : sideButtonsTextSize,
                              onTap: () {
                                poojaDashboardCtrl.clearAddPooja();
                                showPoojaDialog();
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Expanded(
                          child: Obx(
                            () => ListView.separated(
                              shrinkWrap: true,
                              itemCount: poojaDashboardCtrl.poojaData.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      left: 120, right: 120),
                                  child: Card(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 5),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: Colors.black,
                                                  width: 2),
                                            ),
                                            child: Image.network(
                                              poojaDashboardCtrl
                                                      .poojaData[index]
                                                      .stripThumbnail ??
                                                  "",
                                              width: 300,
                                              height: 180,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error,
                                                      stackTrace) =>
                                                  const SizedBox(),
                                            ),
                                          ),
                                          const SizedBox(width: 16),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                    poojaDashboardCtrl
                                                            .poojaData[index]
                                                            .title ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w600)),
                                                const SizedBox(height: 8),
                                                Text(
                                                    poojaDashboardCtrl
                                                            .poojaData[index]
                                                            .description ??
                                                        "",
                                                    style: GoogleFonts.poppins(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 14)),
                                                const SizedBox(height: 8),
                                                poojaDashboardCtrl
                                                            .poojaData[index]
                                                            .date !=
                                                        null
                                                    ? richTextMaker(
                                                        isMobile: false,
                                                        titlePrefix:
                                                            'Pooja Date',
                                                        iconName: Icons
                                                            .calendar_month,
                                                        title:
                                                            poojaDashboardCtrl
                                                                    .poojaData[
                                                                        index]
                                                                    .date ??
                                                                "")
                                                    : const SizedBox.shrink(),
                                                const SizedBox(height: 8),
                                                richTextMaker(
                                                    isMobile: false,
                                                    iconName:
                                                        Icons.numbers_rounded,
                                                    titlePrefix: 'Post Id',
                                                    title: poojaDashboardCtrl
                                                        .poojaData[index].id
                                                        .toString()),
                                                const SizedBox(height: 8),
                                                richTextMaker(
                                                    isMobile: false,
                                                    iconName: Icons
                                                        .currency_rupee_rounded,
                                                    titlePrefix: 'Pooja amount',
                                                    title: poojaDashboardCtrl
                                                        .poojaData[index]
                                                        .displayAmount
                                                        .toString()),
                                                const SizedBox(height: 8),
                                                poojaDashboardCtrl
                                                            .poojaData[index]
                                                            .date ==
                                                        null
                                                    ? Text(
                                                        "Pooja Details Not Completed",
                                                        style:
                                                            GoogleFonts.poppins(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color:
                                                                    Colors.red,
                                                                fontSize: 20),
                                                      )
                                                    : const SizedBox.shrink(),
                                                const SizedBox(height: 8)
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 30),
                                            child: Column(
                                              children: [
                                                Card(
                                                    child: IconButton(
                                                        onPressed: () {
                                                          poojaDetailsCtrl
                                                              .clearData();
                                                          Get.to(() => AddPoojaDetails(
                                                              index: index,
                                                              poojaId: poojaDashboardCtrl
                                                                      .poojaData[
                                                                          index]
                                                                      .id ??
                                                                  0));
                                                        },
                                                        icon: const Icon(
                                                            Icons.edit),
                                                        iconSize: 30)),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 50),
                                                  child: Card(
                                                    child: IconButton(
                                                      onPressed: () {
                                                        showDialog<void>(
                                                          context: context,
                                                          builder: (context) {
                                                            return Center(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(
                                                                        10),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      const BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(10)),
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                  width: 400,
                                                                  height: 150,
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                        .only(
                                                                        top: 20,
                                                                        left:
                                                                            20,
                                                                        right:
                                                                            20,
                                                                        bottom:
                                                                            10),
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'deleteCard'
                                                                              .tr,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                AppConstants.titleSize2,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                            height:
                                                                                20),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            DynamicButton(
                                                                              backgroundColor: AppColors.deleteEditButton,
                                                                              text: 'yes'.tr,
                                                                              width: 100,
                                                                              height: 30,
                                                                              textSize: 14,
                                                                              onTap: () async {
                                                                                await poojaDashboardCtrl.deletePooja(id: poojaDashboardCtrl.poojaData[index].id ?? 0).then((value) => Get.back());
                                                                              },
                                                                            ),
                                                                            const SizedBox(width: 5),
                                                                            DynamicButton(
                                                                              text: 'no'.tr,
                                                                              width: 100,
                                                                              height: 30,
                                                                              textSize: 14,
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      icon: const Icon(
                                                          Icons.delete_forever,
                                                          color: Colors.red),
                                                      iconSize: 30,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
              )
            : const ConnectivityWidget(),
      );
    });
  }

  Future<void> showPoojaDialog() {
    return showDialog<void>(
        context: context,
        builder: ((context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: Colors.white,
                ),
                width: Get.width * 0.5,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Create Pooja",
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            creationSubTitle(
                                "Pooja title",
                                DynamicTextfield(
                                    controller:
                                        poojaDashboardCtrl.poojaTitleController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter pooja title")),

                            creationSubTitle(
                                "Summary Line",
                                DynamicTextfield(
                                    controller: poojaDashboardCtrl
                                        .poojaSummaryLineController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter Summary Title")),
                            creationSubTitle(
                                "Offering Done",
                                DynamicTextfield(
                                    controller: poojaDashboardCtrl
                                        .poojaOfferingDoneController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter Offering Done")),

                            creationSubTitle(
                                "Devotee Count",
                                DynamicTextfield(
                                    controller: poojaDashboardCtrl
                                        .poojaDevoteeCountController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter Devotees")),

                            creationSubTitle(
                                "Pooja description",
                                DynamicTextfield(
                                    minLines: 3,
                                    controller:
                                        poojaDashboardCtrl.poojaDescController,
                                    onChange: (value) {},
                                    maxLength: 200,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter pooja description")),

                            creationSubTitle(
                                "Pooja Pricing",
                                SizedBox(
                                  height: 40,
                                  child: ListView.separated(
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: 20),
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemCount: poojaDashboardCtrl
                                        .poojaPricingData.length,
                                    itemBuilder: (context, index) {
                                      return InkWell(
                                        onTap: () {
                                          poojaDashboardCtrl
                                              .selectedPricingTabIndex
                                              .value = index;
                                          poojaDashboardCtrl
                                              .selectedPricingTabIndex
                                              .refresh();
                                        },
                                        child: Obx(
                                          () => Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  border: Border.all(
                                                      color: Colors.black),
                                                  color: poojaDashboardCtrl
                                                              .selectedPricingTabIndex
                                                              .value ==
                                                          index
                                                      ? Colors.orange.shade200
                                                      : Colors.white),
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10,
                                                    right: 10,
                                                    top: 5,
                                                    bottom: 5),
                                                child: Center(
                                                    child: Text(
                                                  poojaDashboardCtrl
                                                          .poojaPricingData[
                                                              index]
                                                          .displayAmount ??
                                                      "",
                                                  style: GoogleFonts.poppins(
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 18),
                                                )),
                                              )),
                                        ),
                                      );
                                    },
                                  ),
                                )),
                            const SizedBox(
                              height: 20,
                            ),

                            /// pooja LOGO
                            Obx(() {
                              if (dashCtr.partyLogoLoading.value) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.2),
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: Container(
                                    height: 100,
                                    width: 100,
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
                                        height: 100,
                                        width: 100,
                                        child: Text('jhghjkl'),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      dashCtr.pickLogo(
                                          isFromPoojaThumbnail: true,
                                          isFromGuruVani: false,
                                          isFromSanatanGod: false);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 100,
                                      width: 100,
                                      child: poojaDashboardCtrl
                                                  .poojaThumbnail.value ==
                                              ""
                                          ? noPartyLogoWidget("Add thumbnail")
                                          : Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Image.network(
                                                    poojaDashboardCtrl
                                                        .poojaThumbnail.value,
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 75,
                                                          color:
                                                              AppColors.teal50,
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
                                                      poojaDashboardCtrl
                                                          .removePoojaThumbnail();
                                                    },
                                                    icon: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 0.5,
                                                          color:
                                                              AppColors.teal50,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        color: const Color(
                                                            0xFFDC7AA9),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.close,
                                                          color: AppColors
                                                              .whiteCard,
                                                          size: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 20,
                            ),

                            /// SUBMIT BUTTONS
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.whiteCard,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      'cancel'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (poojaDashboardCtrl
                                        .poojaTitleController.text.isEmpty) {
                                      EasyLoading.showError(
                                          'Enter pooja title');
                                      return;
                                    } else if (poojaDashboardCtrl
                                        .poojaDescController.text.isEmpty) {
                                      EasyLoading.showError(
                                          'Enter pooja description');
                                      return;
                                    } else if (poojaDashboardCtrl
                                        .poojaSummaryLineController
                                        .text
                                        .isEmpty) {
                                      EasyLoading.showError(
                                          'Enter Summary Line');
                                      return;
                                    } else if (poojaDashboardCtrl
                                        .poojaOfferingDoneController
                                        .text
                                        .isEmpty) {
                                      EasyLoading.showError(
                                          'Enter Offering Done');
                                      return;
                                    } else if (poojaDashboardCtrl
                                        .poojaDevoteeCountController
                                        .text
                                        .isEmpty) {
                                      EasyLoading.showError(
                                          'Enter Devotee Count');
                                      return;
                                    } else if (poojaDashboardCtrl
                                            .selectedPricingTabIndex.value ==
                                        -1) {
                                      EasyLoading.showError('Select Pricing');
                                      return;
                                    } else if (poojaDashboardCtrl
                                        .poojaThumbnail.value.isEmpty) {
                                      EasyLoading.showError('Select thumbnail');
                                      return;
                                    } else {
                                      poojaDashboardCtrl.createPooja();
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        AppColors.creationSubmitButton,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                    child: Text(
                                      'submit'.tr,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 16,
                                          color: Colors.black),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                              ],
                            ),
                          ])),
                ),
              ),
            ),
          );
        }));
  }

  Widget noPartyLogoWidget(String text) {
    return SizedBox(
        width: 100,
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(width: 0.5, color: Colors.grey)),
          child: Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.add_a_photo,
                  color: Colors.black,
                  size: 30,
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: GoogleFonts.poppins(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
