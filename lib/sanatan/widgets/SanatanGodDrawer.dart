import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/dashboard/view/SanatanDashboard.dart';t
import 'package:shimmer/shimmer.dart';

class SanatanGodDrawer extends StatefulWidget {
  final bool isMobile;

  const SanatanGodDrawer({super.key, required this.isMobile});

  @override
  State<SanatanGodDrawer> createState() => _SanatanGodDrawerState();
}

class _SanatanGodDrawerState extends State<SanatanGodDrawer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: widget.isMobile
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    )),
                title("God List", widget.isMobile),
                const Spacer(),

                /// add god button
                DynamicButton(
                  width: widget.isMobile ? 80 : 140,
                  text: "Add God",
                  height: widget.isMobile ? 26 : 36,
                  textSize: widget.isMobile ? 8 : 12,
                  onTap: () {
                    sanatanGodCtrl.clearAddGod();
                    showPartyDialog(0);
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Obx(
              () => Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  shrinkWrap: true,
                  itemCount: sanatanGodCtrl.sanatanGodList.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: Image.network(
                              height: 90,
                              width: 90,
                              sanatanGodCtrl.sanatanGodList[index].thumbnail ??
                                  "",
                              fit: BoxFit.cover,
                              // Ensures the image fills the container
                              errorBuilder: (context, error, stackTrace) {
                                return Icon(
                                  Icons.image,
                                  size: 40,
                                  color: AppColors.teal50,
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                  sanatanGodCtrl.sanatanGodList[index].title ??
                                      "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  sanatanGodCtrl
                                          .sanatanGodList[index].description ??
                                      "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          // Row(
                          //   mainAxisSize: MainAxisSize.min,
                          //   children: [
                          //     IconButton(
                          //       icon: const Icon(Icons.edit),
                          //       color: AppColors.pink,
                          //       onPressed: () {
                          //         sanatanGodCtrl.guruNameController.text =
                          //             sanatanGodCtrl.sanatanGodList[index].guruName ??
                          //                 "";
                          //         sanatanGodCtrl.guruSloganController?.text =
                          //             sanatanGodCtrl.sanatanGodList[index].guruSlogan ??
                          //                 "";
                          //         sanatanGodCtrl.guruPhoto.value =
                          //             sanatanGodCtrl.sanatanGodList[index].guruLogo ??
                          //                 "";
                          //         sanatanGodCtrl.guruId =
                          //             sanatanGodCtrl.sanatanGodList[index].guruId;
                          //         sanatanGodCtrl.isEditGod.value = true;
                          //         sanatanGodCtrl.isEditGod.refresh();
                          //         showPartyDialog(0);
                          //       },
                          //     ),
                          //     // IconButton(
                          //     //   icon: const Icon(Icons.delete),
                          //     //   color: Colors.black,
                          //     //   onPressed: () {
                          //     //     showDialog<void>(
                          //     //         context: context,
                          //     //         builder: ((context) {
                          //     //           return Center(
                          //     //             child: Padding(
                          //     //               padding: const EdgeInsets.all(10),
                          //     //               child: Container(
                          //     //                 decoration: const BoxDecoration(
                          //     //                   borderRadius: BorderRadius.all(
                          //     //                       Radius.circular(10)),
                          //     //                   color: Colors.white,
                          //     //                 ),
                          //     //                 child: Padding(
                          //     //                   padding:
                          //     //                       const EdgeInsets.all(20),
                          //     //                   child: Column(
                          //     //                     crossAxisAlignment:
                          //     //                         CrossAxisAlignment.center,
                          //     //                     children: [
                          //     //                       Text(
                          //     //                         'deleteParty'.tr,
                          //     //                         style:
                          //     //                             GoogleFonts.poppins(
                          //     //                           fontSize: AppConstants
                          //     //                               .titleSize2,
                          //     //                           fontWeight:
                          //     //                               FontWeight.w400,
                          //     //                         ),
                          //     //                       ),
                          //     //                       const SizedBox(height: 20),
                          //     //                       Row(
                          //     //                         mainAxisAlignment:
                          //     //                             MainAxisAlignment.end,
                          //     //                         children: [
                          //     //                           DynamicButton(
                          //     //                             backgroundColor:
                          //     //                                 AppColors.pink,
                          //     //                             text: 'yes'.tr,
                          //     //                             width: 100,
                          //     //                             height: 30,
                          //     //                             textSize: 14,
                          //     //                             onTap: () {
                          //     //                               sanatanGodCtrl
                          //     //                                       .guruId =
                          //     //                                   sanatanGodCtrl
                          //     //                                       .sanatanGodList[
                          //     //                                           index]
                          //     //                                       .guruId;
                          //     //                               sanatanGodCtrl
                          //     //                                   .deleteGuru();
                          //     //                             },
                          //     //                           ),
                          //     //                           const SizedBox(
                          //     //                               width: 5),
                          //     //                           DynamicButton(
                          //     //                             text: 'no'.tr,
                          //     //                             width: 100,
                          //     //                             height: 30,
                          //     //                             textSize: 14,
                          //     //                             onTap: () {
                          //     //                               Navigator.pop(
                          //     //                                   context);
                          //     //                             },
                          //     //                           ),
                          //     //                         ],
                          //     //                       ),
                          //     //                     ],
                          //     //                   ),
                          //     //                 ),
                          //     //               ),
                          //     //             ),
                          //     //           );
                          //     //         }));
                          //     //   },
                          //     // ),
                          //   ],
                          // ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
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

  Future<void> showPartyDialog(int id) {
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
                              "God Details",
                              style: GoogleFonts.poppins(
                                fontSize: AppConstants.titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            creationSubTitle(
                                "God Name",
                                DynamicTextfield(
                                    controller:
                                        sanatanGodCtrl.godNameController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter God Name")),

                            creationSubTitle(
                                "God Slogan",
                                DynamicTextfield(
                                    controller:
                                        sanatanGodCtrl.godSloganController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter God Slogan")),

                            /// PARTY LOGO
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
                                          isFromPoojaThumbnail: false,
                                          isFromGuruVani: false,
                                          isFromSanatanGod: true);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 100,
                                      width: 100,
                                      child: sanatanGodCtrl.godPhoto.value == ""
                                          ? noPartyLogoWidget("Add God Image")
                                          : Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Image.network(
                                                    sanatanGodCtrl
                                                        .godPhoto.value,
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
                                                      sanatanGodCtrl
                                                          .removeGodhoto();
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
                                  width: 5,
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    if (sanatanGodCtrl
                                        .godNameController.text.isEmpty) {
                                      EasyLoading.showError('Enter god Name');
                                      return;
                                    } else if (sanatanGodCtrl
                                        .godPhoto.value.isEmpty) {
                                      EasyLoading.showError('Add god Image');
                                      return;
                                    } else {
                                      sanatanGodCtrl.createUpdateGod();
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
                                      sanatanGodCtrl.isEditGod.value
                                          ? 'update'.tr
                                          : 'submit'.tr,
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
