import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/AddPoojaDetails.dart';

Widget poojaProcessWidget(
    {required BuildContext context, required int poojaId}) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: DynamicButton(
            text: "Add Process",
            backgroundColor: AppColors.yellowBg,
            width: 150,
            textColor: Colors.black,
            boldness: FontWeight.w500,
            height: 45,
            textSize: 18,
            onTap: () {
              poojaDetailsCtrl.clearController();
              showPoojaDialog(context: context, poojaId: poojaId);
            },
          ),
        ),
      ),
      const SizedBox(height: 20),
      SingleChildScrollView(
        child: Obx(
          () => ListView.builder(
            shrinkWrap: true,
            itemCount: poojaDetailsCtrl.poojaDetailsData.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    trailing: Card(
                      child: IconButton(
                        onPressed: () {},
                        icon:
                            const Icon(Icons.delete_forever, color: Colors.red),
                        iconSize: 30,
                      ),
                    ),
                    leading: Image.network(
                        poojaDetailsCtrl.poojaDetailsData[index].iconUrl ?? ""),
                    onTap: () {},
                    title: Text(
                      poojaDetailsCtrl.poojaDetailsData[index].title ?? "",
                      style: GoogleFonts.poppins(color: Colors.black),
                    ),
                    subtitle: Text(
                        poojaDetailsCtrl.poojaDetailsData[index].description ??
                            ""),
                  ),
                ),
              );
            },
          ),
        ),
      )
    ],
  );
}

Future<void> showPoojaDialog(
    {required BuildContext context, required int poojaId}) {
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
                            "Process Details",
                            style: GoogleFonts.poppins(
                              fontSize: AppConstants.titleSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),

                          creationSubTitle(
                              "Title*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsTitleController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 55,
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter title")),

                          creationSubTitle(
                              "Description*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsDescController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 55,
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter description")),

                          // /// process icon
                          // Obx(() {
                          //   if (dashCtr.partyLogoLoading.value) {
                          //     return Shimmer.fromColors(
                          //       baseColor: Colors.grey.withOpacity(0.2),
                          //       highlightColor: Colors.grey.withOpacity(0.1),
                          //       child: Container(
                          //         height: 100,
                          //         width: 100,
                          //         decoration: const BoxDecoration(
                          //           gradient: LinearGradient(
                          //             colors: [
                          //               Color(0xFFFFA5A8),
                          //               Color(0xFFFFE3F6),
                          //             ],
                          //             begin: Alignment.topLeft,
                          //             end: Alignment.bottomRight,
                          //           ),
                          //           borderRadius:
                          //               BorderRadius.all(Radius.circular(12)),
                          //         ),
                          //         child: const Padding(
                          //           padding: EdgeInsets.all(15),
                          //           child: SizedBox(
                          //             height: 100,
                          //             width: 100,
                          //             child: Text('jhghjkl'),
                          //           ),
                          //         ),
                          //       ),
                          //     );
                          //   } else {
                          //     return Padding(
                          //       padding: const EdgeInsets.only(left: 10),
                          //       child: GestureDetector(
                          //         onTap: () {
                          //           dashCtr.pickLogo(
                          //               isFromPoojaThumbnail: true,
                          //               isFromGuruVani: false,
                          //               isFromSanatanGod: false);
                          //         },
                          //         child: Container(
                          //           color: Colors.white,
                          //           height: 100,
                          //           width: 100,
                          //           child: poojaDashboardCtrl
                          //                       .poojaThumbnail.value ==
                          //                   ""
                          //               ? noPartyLogoWidget("Add Icon")
                          //               : Stack(
                          //                   children: [
                          //                     ClipRRect(
                          //                       borderRadius:
                          //                           const BorderRadius.all(
                          //                               Radius.circular(20)),
                          //                       child: Image.network(
                          //                         poojaDashboardCtrl
                          //                             .poojaThumbnail.value,
                          //                         height: 100,
                          //                         width: 100,
                          //                         fit: BoxFit.cover,
                          //                         errorBuilder: (context, error,
                          //                             stackTrace) {
                          //                           return Center(
                          //                             child: Icon(
                          //                               Icons.image,
                          //                               size: 75,
                          //                               color: AppColors.teal50,
                          //                             ),
                          //                           );
                          //                         },
                          //                       ),
                          //                     ),
                          //                     Positioned(
                          //                       top: -8,
                          //                       right: -8,
                          //                       child: IconButton(
                          //                         onPressed: () {
                          //                           poojaDashboardCtrl
                          //                               .removePoojaThumbnail();
                          //                         },
                          //                         icon: Container(
                          //                           decoration: BoxDecoration(
                          //                             border: Border.all(
                          //                               width: 0.5,
                          //                               color: AppColors.teal50,
                          //                             ),
                          //                             shape: BoxShape.circle,
                          //                             color: const Color(
                          //                                 0xFFDC7AA9),
                          //                           ),
                          //                           child: Center(
                          //                             child: Icon(
                          //                               Icons.close,
                          //                               color:
                          //                                   AppColors.whiteCard,
                          //                               size: 10,
                          //                             ),
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ),
                          //                   ],
                          //                 ),
                          //         ),
                          //       ),
                          //     );
                          //   }
                          // }),
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
                                  if (poojaDetailsCtrl
                                      .poojaDetailsTitleController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError('Enter title');
                                    return;
                                  } else if (poojaDetailsCtrl
                                      .poojaDetailsDescController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError('Enter description');
                                    return;
                                  } else {
                                    poojaDetailsCtrl.updatePoojaDetails(
                                        poojaId: poojaId, whichTab: "process");
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
