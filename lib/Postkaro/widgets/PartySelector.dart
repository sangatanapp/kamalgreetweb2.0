import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'MultiplePartySelector.dart';

Widget partySelector() {
  return Obx(
    () => Visibility(
      visible: subCategoryCtrl.fieldNameMapping.value.contains('political'),
      // visible: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// PARTY SELECTOR
              Flexible(
                  flex: 1,
                  fit: FlexFit.tight,
                  child: creationSubTitle(
                      'party'.tr,
                      InkWell(
                        onTap: () => multiplePartySelector(),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border:
                                Border.all(width: .5, color: Colors.black54),
                            color: Colors.white,
                          ),
                          height: 50,
                          width: 300,
                          child: Center(
                            child: Text("Select Party",
                                style: TextStyle(color: Colors.black)),
                          ),
                        ),
                      ))),

              const SizedBox(
                width: 20,
              ),

              const Flexible(
                flex: 1,
                fit: FlexFit.tight,
                child: SizedBox(),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Obx(() {
            if (postKaroCreationCtrl.selectedPartyNameList.value.isNotEmpty) {
              return Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: postKaroCreationCtrl.selectedPartyNameList.value.map((tag) {
                  return Chip(
                    labelStyle: TextStyle(color: Colors.blue.shade800),
                    backgroundColor: Colors.orange.shade100,
                    label: Text(
                      tag,
                      style: GoogleFonts.poppins(),
                    ),
                    onDeleted: () {
                      int selectedIndex =
                          postKaroCreationCtrl.partyNameList.indexOf(tag);

                      postKaroCreationCtrl.selectedPartyNameList.value.remove(tag);
                      postKaroCreationCtrl.partyIdList.value.remove(
                          postKaroCreationCtrl.partyList[selectedIndex].partyId);

                      print(
                          "----------> ${postKaroCreationCtrl.selectedPartyNameList.value}");
                      print("----------> ${postKaroCreationCtrl.partyIdList.value}");

                      postKaroCreationCtrl.selectedPartyNameList.refresh();
                    },
                    deleteIconColor: Colors.blue.shade800,
                  );
                }).toList(),
              );
            } else {
              return const SizedBox();
            }
          }),
        ],
      ),
    ),
  );
}
