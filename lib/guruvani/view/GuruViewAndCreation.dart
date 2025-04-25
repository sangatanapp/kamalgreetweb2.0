import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/commonImagePickers/LogoPickerViewModel.dart';
import 'package:kamal_greet_web_2/commonImagePickers/widgets/NoLogoWidget.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';
import 'package:shimmer/shimmer.dart';

class GuruViewAndCreation extends StatefulWidget {
  const GuruViewAndCreation({super.key});

  @override
  State<GuruViewAndCreation> createState() => _GuruViewAndCreationState();
}

class _GuruViewAndCreationState extends State<GuruViewAndCreation> {
  final LogoPickerViewModel logoPickerCtrl = Get.put(LogoPickerViewModel());

  @override
  void initState() {
    guruvaniCtrl.getGuruList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Obx(
            () => Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: ListView.separated(
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  shrinkWrap: true,
                  itemCount: guruvaniCtrl.guruList.length,
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
                              guruvaniCtrl.guruList[index].guruLogo ?? "",
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
                                  guruvaniCtrl.guruList[index].guruName ?? "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14),
                                ),
                                Text(
                                  guruvaniCtrl.guruList[index].guruSlogan ?? "",
                                  style: GoogleFonts.poppins(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                color: AppColors.pink,
                                onPressed: () {
                                  guruvaniCtrl.guruNameController.text =
                                      guruvaniCtrl.guruList[index].guruName ??
                                          "";
                                  guruvaniCtrl.guruSloganController?.text =
                                      guruvaniCtrl.guruList[index].guruSlogan ??
                                          "";
                                  guruvaniCtrl.guruPhoto.value =
                                      guruvaniCtrl.guruList[index].guruLogo ??
                                          "";
                                  guruvaniCtrl.guruId =
                                      guruvaniCtrl.guruList[index].guruId;
                                  guruvaniCtrl.isEditGuru.value = true;
                                  guruvaniCtrl.isEditGuru.refresh();
                                },
                              ),
                              // IconButton(
                              //   icon: const Icon(Icons.delete),
                              //   color: Colors.black,
                              //   onPressed: () {
                              //     showDialog<void>(
                              //         context: context,
                              //         builder: ((context) {
                              //           return Center(
                              //             child: Padding(
                              //               padding: const EdgeInsets.all(10),
                              //               child: Container(
                              //                 decoration: const BoxDecoration(
                              //                   borderRadius: BorderRadius.all(
                              //                       Radius.circular(10)),
                              //                   color: Colors.white,
                              //                 ),
                              //                 child: Padding(
                              //                   padding:
                              //                       const EdgeInsets.all(20),
                              //                   child: Column(
                              //                     crossAxisAlignment:
                              //                         CrossAxisAlignment.center,
                              //                     children: [
                              //                       Text(
                              //                         'deleteParty'.tr,
                              //                         style:
                              //                             GoogleFonts.poppins(
                              //                           fontSize: AppConstants
                              //                               .titleSize2,
                              //                           fontWeight:
                              //                               FontWeight.w400,
                              //                         ),
                              //                       ),
                              //                       const SizedBox(height: 20),
                              //                       Row(
                              //                         mainAxisAlignment:
                              //                             MainAxisAlignment.end,
                              //                         children: [
                              //                           DynamicButton(
                              //                             backgroundColor:
                              //                                 AppColors.pink,
                              //                             text: 'yes'.tr,
                              //                             width: 100,
                              //                             height: 30,
                              //                             textSize: 14,
                              //                             onTap: () {
                              //                               guruvaniCtrl
                              //                                       .guruId =
                              //                                   guruvaniCtrl
                              //                                       .guruList[
                              //                                           index]
                              //                                       .guruId;
                              //                               guruvaniCtrl
                              //                                   .deleteGuru();
                              //                             },
                              //                           ),
                              //                           const SizedBox(
                              //                               width: 5),
                              //                           DynamicButton(
                              //                             text: 'no'.tr,
                              //                             width: 100,
                              //                             height: 30,
                              //                             textSize: 14,
                              //                             onTap: () {
                              //                               Navigator.pop(
                              //                                   context);
                              //                             },
                              //                           ),
                              //                         ],
                              //                       ),
                              //                     ],
                              //                   ),
                              //                 ),
                              //               ),
                              //             ),
                              //           );
                              //         }));
                              //   },
                              // ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                    color: Colors.white),
                width: MediaQuery.of(context).size.width * 0.5,
                child: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "Guru Details",
                              style: GoogleFonts.poppins(
                                  fontSize: AppConstants.titleSize,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(height: 10),

                            creationSubTitle(
                                "Guru Name",
                                DynamicTextfield(
                                    controller: guruvaniCtrl.guruNameController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter Guru Name")),

                            creationSubTitle(
                                "Guru Slogan",
                                DynamicTextfield(
                                    controller:
                                        guruvaniCtrl.guruSloganController,
                                    onChange: (value) {},
                                    maxLength: 50,
                                    height: 55,
                                    fillColor: AppColors.whiteCard,
                                    hintText: "Enter Guru Slogan")),

                            /// PARTY LOGO
                            Obx(() {
                              if (logoPickerCtrl.partyLogoLoading.value) {
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
                                          Color(0xFFFFE3F6)
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
                                      logoPickerCtrl.pickLogo(
                                          isFromSanatanGod: false,
                                          isFromGuruVani: true);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 100,
                                      width: 100,
                                      child: guruvaniCtrl.guruPhoto.value == ""
                                          ? noLogoWidget("Add Guru Image")
                                          : Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Image.network(
                                                    guruvaniCtrl
                                                        .guruPhoto.value,
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
                                                      guruvaniCtrl
                                                          .removeGuruPhoto();
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
                            const SizedBox(height: 20),

                            /// SUBMIT BUTTONS
                            Obx(
                              () => Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      guruvaniCtrl.clearAddGuru();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.whiteCard,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text('Reset'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (guruvaniCtrl
                                          .guruNameController.text.isEmpty) {
                                        EasyLoading.showError(
                                            'Enter Guru Name');
                                        return;
                                      } else if (guruvaniCtrl
                                          .guruPhoto.value.isEmpty) {
                                        EasyLoading.showError('Add Guru Image');
                                        return;
                                      } else {
                                        guruvaniCtrl.createUpdateGuru();
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          AppColors.creationSubmitButton,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 15),
                                      child: Text(
                                          guruvaniCtrl.isEditGuru.value
                                              ? 'update'.tr
                                              : 'submit'.tr,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 16,
                                              color: Colors.black)),
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                ],
                              ),
                            ),
                          ])),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
