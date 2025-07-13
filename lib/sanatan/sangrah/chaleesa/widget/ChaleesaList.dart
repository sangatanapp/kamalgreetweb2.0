import 'package:flutter/material.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/sanatan/sangrah/chaleesa/view/ChaleesaCreationScreen.dart';

import 'package:kamal_greet_web_2/sanatan/widgets/HelperListMaker.dart';

Widget chaleesaListWidget(bool isMobile) {
  if (chaleesaCtrl.chaleesaList.isEmpty) {
    return Center(
      child: Card(
        color: Colors.yellow.shade100,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.warning_amber_rounded,
                size: 50,
                color: Colors.orange.shade800,
              ),
              const SizedBox(height: 10),
              Text(
                'No Data Available',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  return ListView.separated(
    separatorBuilder: (context, index) {
      return const SizedBox(
        height: 10,
      );
    },
    // controller: dashCtr.scrollController,
    shrinkWrap: true,
    itemCount: chaleesaCtrl.chaleesaList.length,
    itemBuilder: ((context, index) {
      String formattedDescription =
          chaleesaCtrl.chaleesaList[index].descriptionTitle ??
              "".replaceAll('\n', ' ');
      print("i am desc - > $formattedDescription");
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 2,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade700, width: 0.5),
                  borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// UI
                      Expanded(
                        flex: 3,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Text(
                                chaleesaCtrl.chaleesaList[index].title ?? "",
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: isMobile ? 12 : 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            Flexible(
                              flex: 1,
                              child: Text(
                                formattedDescription,
                                overflow: TextOverflow.ellipsis,
                                style: GoogleFonts.poppins(
                                  fontSize: isMobile ? 12 : 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            /// God Id
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: richTextMaker(
                                      isMobile: isMobile,
                                      iconName: Icons.accessibility_rounded,
                                      titlePrefix: 'God Id',
                                      title: chaleesaCtrl
                                          .chaleesaList[index].godId
                                          .toString()),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: richTextMaker(
                                      isMobile: isMobile,
                                      iconName: Icons.accessibility_rounded,
                                      titlePrefix: 'Post id',
                                      title: chaleesaCtrl.chaleesaList[index].id
                                          .toString()),
                                ),
                                IconButton(
                                    onPressed: () {
                                      showDialog<void>(
                                        context: context,
                                        builder: (context) {
                                          return Center(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(10)),
                                                  color: Colors.white,
                                                ),
                                                width: 400,
                                                height: 150,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 20,
                                                          left: 20,
                                                          right: 20,
                                                          bottom: 10),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'deleteCard'.tr,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: AppConstants
                                                              .titleSize2,
                                                          fontWeight:
                                                              FontWeight.w400,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          height: 20),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          DynamicButton(
                                                            backgroundColor:
                                                                AppColors
                                                                    .deleteEditButton,
                                                            text: 'yes'.tr,
                                                            width: 100,
                                                            height: 30,
                                                            textSize: 14,
                                                            onTap: () {
                                                              chaleesaCtrl.deleteCard(
                                                                  chaleesaCtrl
                                                                          .chaleesaList[
                                                                              index]
                                                                          .id ??
                                                                      0);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                          const SizedBox(
                                                              width: 5),
                                                          DynamicButton(
                                                            text: 'no'.tr,
                                                            width: 100,
                                                            height: 30,
                                                            textSize: 14,
                                                            onTap: () {
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(
                                      Icons.delete_forever,
                                      color: Colors.red,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }),
  );
}
