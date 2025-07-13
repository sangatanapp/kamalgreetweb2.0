import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/database/GreetStorage.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';


class DynamicAppbar extends StatelessWidget {
  final String whichApp;

  const DynamicAppbar({super.key, required this.whichApp});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          final isMobile = constraints.maxWidth < 600;
          return Container(
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: isMobile ? 50 : 70,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    isMobile
                        ? const SizedBox(
                      width: 20,
                    )
                        : const SizedBox(
                      width: 50,
                    ),
                    whichApp == "guruvani" ? Image.asset(
                        width: 100, "assets/images/guruvanilogo.png"):const SizedBox.shrink(),
                  ],
                ),
                // Row(
                //   children: [
                //     Padding(
                //       padding:
                //           const EdgeInsets.only(right: 15, top: 15, bottom: 15),
                //       child: Container(
                //         padding: const EdgeInsets.only(left: 10, right: 10),
                //         decoration: BoxDecoration(
                //             border:
                //                 Border.all(width: 0.5, color: Colors.grey.shade500),
                //             color: Colors.white,
                //             borderRadius: BorderRadius.circular(6)),
                //         child: DropdownButton<String>(
                //           value: dashCtr.langValue.value,
                //           icon: const Icon(
                //             Icons.arrow_drop_down,
                //             color: Colors.black,
                //           ),
                //           iconSize: 22,
                //           elevation: 16,
                //           underline: const SizedBox(),
                //           style: GoogleFonts.poppins(
                //             color: Colors.black,
                //           ),
                //           onChanged: (String? value) {
                //             dashCtr.langValue.value = value!;
                //             if (value == "English") {
                //               Get.updateLocale(const Locale('en', 'US'));
                //             }
                //             if (value == "Hindi") {
                //               Get.updateLocale(const Locale('hi', 'IN'));
                //             }
                //           },
                //           items: dashCtr.langList.value
                //               .map<DropdownMenuItem<String>>((String value) {
                //             return DropdownMenuItem<String>(
                //               value: value,
                //               child: Text(value),
                //             );
                //           }).toList(),
                //         ),
                //       ),
                //     ),
                //     const SizedBox(
                //       width: 5,
                //     ),
                //     IconButton(
                //         onPressed: () {
                //           Get.offAll(const LoginPage());
                //           loginController.phoneNumber.value.clear();
                //           GreetStorage.cleanAllLocalStorage();
                //         },
                //         icon: const Icon(
                //           Icons.logout,
                //           color: Colors.black,
                //         )),
                //     const SizedBox(
                //       width: 10,
                //     ),
                //   ],
                // ),
              ],
            ),
          );
        });
  }
}


