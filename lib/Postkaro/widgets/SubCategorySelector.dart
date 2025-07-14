import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CreationDecorations.dart';

Widget subCategorySelector(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                onTap: () {
                  if (subCategoryCtrl.allSuggestions.isEmpty) {
                    EasyLoading.showError('Please Select Language First');
                    return;
                  }
                },
                controller: subCategoryCtrl.subCatergoryCtrl.value,
                decoration: CreationDecorations().inputDecoration(
                  labelText: "addSubCategory".tr,
                  // suffixIcon: IconButton(
                  //   icon: const Icon(Icons.arrow_drop_down),
                  //   onPressed: () {
                  //     showSuggestionsDialog(context);
                  //   },
                  // )
                ),
                onSubmitted: (text) async {
                  if (subCategoryCtrl.allSuggestions.contains(text) &&
                      subCategoryCtrl.tagMapping.length < 2) {
                    subCategoryCtrl.addTag(
                      text,
                      subCategoryCtrl.tagHashMap[text]!,
                      subCategoryCtrl.fieldNameHashMap[text]!,
                    );
                    subCategoryCtrl.subCatergoryCtrl.value.clear();
                  } else {
                    EasyLoading.showError(
                        'No Tag Found or Maximum Tags Reached');
                  }
                  // if (subCategoryCtrl.tagMapping.value.contains('political')) {
                  //   await postKaroCreationCtrl.callPartyListApi();
                  //   showDialog<void>(
                  //       barrierDismissible: false,
                  //       context: context,
                  //       builder: ((context) {
                  //         return partyLogoDialog(context);
                  //       }));
                  // }
                },
              ),
              suggestionsCallback: (pattern) async {
                return subCategoryCtrl.allSuggestions
                    .where((suggestion) => suggestion
                        .toLowerCase()
                        .startsWith(pattern.toLowerCase()))
                    .toList();
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) async {
                if (subCategoryCtrl.tagMapping.length < 5) {
                  subCategoryCtrl.addTag(
                      suggestion,
                      subCategoryCtrl.tagHashMap[suggestion]!,
                      subCategoryCtrl.fieldNameHashMap[suggestion]!);
                  subCategoryCtrl.subCatergoryCtrl.value.clear();
                  if (subCategoryCtrl.fieldNameHashMap[suggestion]!
                      .contains("political")) {
                    postKaroCreationCtrl.callPartyListApi();
                  }
                } else {
                  EasyLoading.showError('No Tag Found or Maximum Tags Reached');
                }
              },
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 3,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const Icon(
            Icons.info,
            size: 12,
            color: Colors.grey,
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            'pressEnterSubCategory'.tr,
            style: GoogleFonts.poppins(
              fontSize: 12,
              color: Colors.grey,
            ),
          )
        ],
      ),
      const SizedBox(
        height: 5,
      ),
      Obx(() {
        if (subCategoryCtrl.tagMapping.isNotEmpty) {
          return Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: subCategoryCtrl.tagMapping.map((tag) {
              return Chip(
                labelStyle: TextStyle(color: Colors.blue.shade800),
                backgroundColor: Colors.blue.shade100,
                label: Text(tag),
                onDeleted: () {
                  print(tag);
                  if (tag.toLowerCase() == 'political') {
                    postKaroCreationCtrl.selectedPartyNameList.value = [];
                    postKaroCreationCtrl.partyIdList.value = [];
                    postKaroCreationCtrl.selectedPartyNameList.refresh();
                    postKaroCreationCtrl.partyIdList.refresh();
                    postKaroCreationCtrl.partyIdList.value = [];
                    postKaroCreationCtrl.finalPartyLogo.value = "";
                    postKaroCreationCtrl.selectedPartyLogo.value = -1;
                    postKaroCreationCtrl.finalPartyName.value = "";
                    postKaroCreationCtrl.selectedPartyName.value = "";
                  }
                  subCategoryCtrl.removeTag(
                      tag,
                      subCategoryCtrl.tagHashMap[tag]!,
                      subCategoryCtrl.fieldNameHashMap[tag]!);
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
  );
}
