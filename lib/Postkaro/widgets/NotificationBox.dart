import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';

Widget notificationBox() {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 20),
    decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 0.5, color: Colors.grey),
        borderRadius: BorderRadius.circular(12)),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'notificationMessage'.tr,
            style:
                GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                margin: const EdgeInsets.all(5),
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(width: 2, color: Colors.grey.shade200),
                ),
                child: Image.asset(
                  'assets/images/bell.png',
                  width: 20,
                  height: 20,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Obx(() => Row(
                    children: [
                      OutlinedButton(
                        onPressed: () {
                          postKaroCreationCtrl.notifyUsers.value = true;
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: postKaroCreationCtrl.notifyUsers.value
                              ? AppColors.positionButton
                              : Colors.white,
                          side: BorderSide(color: Colors.grey.shade200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'yes'.tr,
                          style: TextStyle(
                            color: postKaroCreationCtrl.notifyUsers.value
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      OutlinedButton(
                        onPressed: () {
                          postKaroCreationCtrl.notifyUsers.value = false;
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: !postKaroCreationCtrl.notifyUsers.value
                              ? AppColors.positionButton
                              : Colors.white,
                          side: BorderSide(color: Colors.grey.shade200),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: Text(
                          'no'.tr,
                          style: TextStyle(
                            color: !postKaroCreationCtrl.notifyUsers.value
                                ? Colors.white
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  )),
            ],
          ),
          const SizedBox(height: 10),
          Obx(() {
            if (postKaroCreationCtrl.notifyUsers.value) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(color: Colors.grey),
                  Text(
                    'Select Options',
                    style: GoogleFonts.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 10),
                  SizedBox(
                    height: 40,
                    child: ListView.builder(
                      itemBuilder: (context, index) {
                        return SizedBox(
                          width: 180,
                          child: Obx(
                            () => CheckboxListTile(
                              contentPadding: EdgeInsets.zero,
                              title: Text(
                                  postKaroCreationCtrl.postKaroNotificationList[index]),
                              value: postKaroCreationCtrl
                                  .selectedPostKaroNotificationList
                                  .contains(postKaroCreationCtrl
                                      .postKaroNotificationList[index]),
                              onChanged: (value) {
                                if (value == true) {
                                  postKaroCreationCtrl.selectedPostKaroNotificationList
                                      .add(postKaroCreationCtrl
                                          .postKaroNotificationList[index]);
                                  postKaroCreationCtrl.selectedPostKaroNotificationList
                                      .refresh();
                                } else {
                                  postKaroCreationCtrl.selectedPostKaroNotificationList
                                      .remove(postKaroCreationCtrl
                                          .postKaroNotificationList[index]);
                                  postKaroCreationCtrl.selectedPostKaroNotificationList
                                      .refresh();
                                }

                                print(
                                    " i am old list => ${postKaroCreationCtrl.postKaroNotificationList}");
                                print(
                                    " i am selected list => ${postKaroCreationCtrl.selectedPostKaroNotificationList}");
                              },
                              controlAffinity: ListTileControlAffinity.leading,
                            ),
                          ),
                        );
                      },
                      itemCount: postKaroCreationCtrl.postKaroNotificationList.length,
                      scrollDirection: Axis.horizontal,
                    ),
                  )
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
    ),
  );
}
