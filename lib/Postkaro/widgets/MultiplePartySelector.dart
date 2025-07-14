import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/main.dart';

Future multiplePartySelector() {
  // Sample data
  final List<String> items = postKaroCreationCtrl.partyNameList;
  return showDialog(
    context: NavigationService.navigatorKey.currentContext!,
    builder: (context) {
      return Padding(
        padding:
            const EdgeInsets.only(left: 300, right: 300, bottom: 100, top: 100),
        child: AlertDialog(
          title: const Text("Select Options"),
          content: StatefulBuilder(
            builder: (context, setState) {
              return SizedBox(
                width: double.maxFinite,
                child: ListView(
                  children: items.map((item) {
                    return Obx(
                      () => CheckboxListTile(
                        controlAffinity: ListTileControlAffinity.leading,
                        title: Text(item),
                        value:
                            postKaroCreationCtrl.selectedPartyNameList.contains(item),
                        onChanged: (value) {
                          if (value == true) {
                            if (item == "Select All") {
                              for (int i = 0;
                                  i < postKaroCreationCtrl.partyNameList.length;
                                  i++) {
                                if (i == 0) {
                                  postKaroCreationCtrl.selectedPartyNameList
                                      .add(postKaroCreationCtrl.partyNameList[i]);
                                  continue;
                                }
                                postKaroCreationCtrl.selectedPartyNameList
                                    .add(postKaroCreationCtrl.partyNameList[i]);
                                int selectedIndex = postKaroCreationCtrl.partyNameList
                                    .indexOf(postKaroCreationCtrl.partyNameList[i]);
                                postKaroCreationCtrl.partyIdList.add(postKaroCreationCtrl
                                    .partyList[selectedIndex].partyId);
                              }
                            } else {
                              postKaroCreationCtrl.selectedPartyNameList.add(item);
                              int selectedIndex =
                                  postKaroCreationCtrl.partyNameList.indexOf(item);

                              postKaroCreationCtrl.partyIdList.add(postKaroCreationCtrl
                                  .partyList[selectedIndex].partyId);
                            }
                          } else {
                            if (item == "Select All") {
                              postKaroCreationCtrl.selectedPartyNameList.value = [];
                              postKaroCreationCtrl.partyIdList.value = [];
                            } else {
                              postKaroCreationCtrl.selectedPartyNameList.remove(item);
                              int selectedIndex =
                                  postKaroCreationCtrl.partyNameList.indexOf(item);

                              postKaroCreationCtrl.partyIdList.remove(postKaroCreationCtrl
                                  .partyList[selectedIndex].partyId);
                            }
                          }
                          postKaroCreationCtrl.selectedPartyNameList.refresh();

                          // setState(() {

                          //   selectedItems[item] = value ?? false;
                          // });

                          print(postKaroCreationCtrl.partyIdList);

                          print(postKaroCreationCtrl.selectedPartyNameList);
                        },
                      ),
                    );
                  }).toList(),
                ),
              );
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Confirm"),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel"),
            ),
          ],
        ),
      );
    },
  );
}
