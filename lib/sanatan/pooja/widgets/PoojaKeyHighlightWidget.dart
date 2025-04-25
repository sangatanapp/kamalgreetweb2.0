import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/view/AddPoojaDetails.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/HelperListMaker.dart';

Widget poojaKeyHighlightWidget(
    {required BuildContext context,
    required int poojaId,
    required String date,
    required String poojaLocation,
    required String offering,
    required String special,
    required String aboutUs,
    required String socialProof}) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: DynamicButton(
            text: "Add Key Highlight",
            backgroundColor: AppColors.yellowBg,
            width: 200,
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
      Card(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: ListView(
            shrinkWrap: true,
            children: [
              const SizedBox(height: 8),
              richTextMaker(
                  isMobile: false,
                  iconName: Icons.calendar_month,
                  titlePrefix: 'Date',
                  title: date),
              // const SizedBox(height: 8),
              // richTextMaker(
              //     isMobile: false,
              //     iconName: Icons.location_on,
              //     titlePrefix: 'Pooja Location',
              //     title: poojaLocation),
              const SizedBox(height: 8),
              richTextMaker(
                  isMobile: false,
                  iconName: Icons.local_offer_outlined,
                  titlePrefix: 'Offering',
                  title: offering),
              const SizedBox(height: 8),
              richTextMaker(
                  isMobile: false,
                  iconName: Icons.folder_special,
                  titlePrefix: 'Special',
                  title: special),
              const SizedBox(height: 8),
              richTextMaker(
                  isMobile: false,
                  iconName: Icons.description,
                  titlePrefix: 'About us',
                  title: aboutUs),
              const SizedBox(height: 8),
              richTextMaker(
                  isMobile: false,
                  iconName: Icons.person,
                  titlePrefix: 'Social Proof',
                  title: socialProof)
            ],
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
                            "Key Highlight Details",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 8),

                          creationSubTitle(
                              "Date*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsTitleController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 40,
                                  counterText: "",
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter Date")),
                          // const SizedBox(height: 5),
                          // creationSubTitle(
                          //     "Pooja location",
                          //     DynamicTextfield(
                          //         controller: poojaDetailsCtrl
                          //             .poojaDetailsDescController,
                          //         onChange: (value) {},
                          //         maxLength: 50,
                          //         height: 40,
                          //         counterText: "",
                          //         fillColor: AppColors.whiteCard,
                          //         hintText: "Enter Pooja location")),
                          const SizedBox(height: 5),
                          creationSubTitle(
                              "Offering*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsOfferingController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 40,
                                  counterText: "",
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter Offering")),
                          const SizedBox(height: 5),
                          creationSubTitle(
                              "Special tag*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsSpecialOccasionController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 40,
                                  counterText: "",
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter Special tag")),
                          const SizedBox(height: 5),
                          creationSubTitle(
                              "Special Proof*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsSocialProofController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 40,
                                  counterText: "",
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter Social Proof")),
                          const SizedBox(height: 5),
                          creationSubTitle(
                              "About Us*",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsAboutUsController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  minLines: 2,
                                  height: 55,
                                  counterText: "",
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter About us")),
                          const SizedBox(height: 20),

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
                                    EasyLoading.showError('Enter date');
                                    return;
                                  }
                                  // else if (poojaDetailsCtrl
                                  //     .poojaDetailsDescController
                                  //     .text
                                  //     .isEmpty) {
                                  //   EasyLoading.showError(
                                  //       'Enter pooja location');
                                  //   return;
                                  // }
                                  //
                                  else if (poojaDetailsCtrl
                                      .poojaDetailsOfferingController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError('Enter offering');
                                    return;
                                  } else if (poojaDetailsCtrl
                                      .poojaDetailsSpecialOccasionController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError(
                                        'Enter special occasion');
                                    return;
                                  } else if (poojaDetailsCtrl
                                      .poojaDetailsSocialProofController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError('Enter Social Proof');
                                    return;
                                  } else if (poojaDetailsCtrl
                                      .poojaDetailsAboutUsController
                                      .text
                                      .isEmpty) {
                                    EasyLoading.showError('Enter About us');
                                    return;
                                  } else {
                                    poojaDetailsCtrl.updatePoojaDetails(
                                        whichTab: "keyHighlights",
                                        poojaId: poojaId);
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
