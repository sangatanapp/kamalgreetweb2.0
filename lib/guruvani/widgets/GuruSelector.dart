import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CreationDecorations.dart';
import 'package:kamal_greet_web_2/guruvani/view/GuruvaniDashboard.dart';

Widget guruSelector(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          Expanded(
            child: TypeAheadField<String>(
              textFieldConfiguration: TextFieldConfiguration(
                onTap: () {},
                decoration: CreationDecorations()
                    .inputDecoration(labelText: "Select Guru"),
                onSubmitted: (text) async {
                  if (guruvaniCtrl.selectedGuruName.value.contains(text)) {
                    EasyLoading.showInfo("Guru Alrady Added");
                  } else {
                    guruvaniCtrl.addGuru(text);
                  }
                },
              ),
              suggestionsCallback: (pattern) async {
                return guruvaniCtrl.allGuruSuggestions;
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) async {
                if (guruvaniCtrl.selectedGuruName.contains(suggestion)) {
                  EasyLoading.showInfo("Guru Alrady Added");
                } else {
                  guruvaniCtrl.addGuru(suggestion);
                  print("${guruvaniCtrl.selectedGuruName}");
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
        if (guruvaniCtrl.selectedGuruName.isNotEmpty) {
          return Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: guruvaniCtrl.selectedGuruName.map((tag) {
              return Chip(
                labelStyle: TextStyle(color: Colors.blue.shade800),
                backgroundColor: Colors.blue.shade100,
                label: Text(tag),
                onDeleted: () {
                  guruvaniCtrl.selectedGuruName
                      .removeWhere((element) => element == tag);

                  guruvaniCtrl.selectedGuruName.refresh();
                  print("${guruvaniCtrl.selectedGuruName}");
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
