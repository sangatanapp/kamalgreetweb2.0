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

Widget poojaPackageWidget(
    {required BuildContext context, required int poojaId}) {
  return Column(
    children: [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 30),
          child: DynamicButton(
            text: "Add Package",
            backgroundColor: AppColors.yellowBg,
            width: 160,
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
      Obx(
        () => ListView.builder(
          shrinkWrap: true,
          itemCount: poojaDetailsCtrl.poojaDetailsData.length,
          itemBuilder: (context, index) {
            return Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  onTap: () {},
                  title: Text(
                    poojaDetailsCtrl.poojaDetailsData[index].featureTitle ?? "",
                    style: GoogleFonts.poppins(color: Colors.black),
                  ),
                  subtitle: Text(poojaDetailsCtrl
                          .poojaDetailsData[index].featureDescription ??
                      ""),
                ),
              ),
            );
          },
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
                            "Package Details",
                            style: GoogleFonts.poppins(
                              fontSize: AppConstants.titleSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 10),

                          creationSubTitle(
                              "Title",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsTitleController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 55,
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter title")),

                          creationSubTitle(
                              "Description",
                              DynamicTextfield(
                                  controller: poojaDetailsCtrl
                                      .poojaDetailsDescController,
                                  onChange: (value) {},
                                  maxLength: 50,
                                  height: 55,
                                  fillColor: AppColors.whiteCard,
                                  hintText: "Enter description")),
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
                                        poojaId: poojaId, whichTab: "package");
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
