import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/sanatan/widgets/HelperListMaker.dart';
import '../../dashboard/view/SanatanDashboard.dart';

Widget wallpaperListWidget(bool isMobile) {
  if (wallpaperCtrl.sanatanWallpaperList.isEmpty) {
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
    itemCount: wallpaperCtrl.sanatanWallpaperList.length,
    itemBuilder: ((context, index) {
      return SizedBox(
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.height * 0.32,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Container(
                width:
                    isMobile ? 150 : MediaQuery.of(context).size.width * 0.13,
                height:
                    isMobile ? 150 : MediaQuery.of(context).size.width * 0.18,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade700, width: 0.5),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                ),
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      bottomLeft: Radius.circular(20)),
                  child: Image.network(
                    wallpaperCtrl.sanatanWallpaperList[index].postUrl ?? "",
                    fit: BoxFit.fill,
                    alignment: Alignment.topCenter,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          Icons.image,
                          size: 75,
                          color: AppColors.teal50,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
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
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flexible(
                                    flex: 5,
                                    child: Text(
                                      wallpaperCtrl.sanatanWallpaperList[index]
                                              .title ??
                                          "",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.poppins(
                                        fontSize: isMobile ? 12 : 18,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            /// CREATED DATE
                            Flexible(
                              flex: 1,
                              child: richTextMaker(
                                  isMobile: isMobile,
                                  iconName: Icons.calendar_month,
                                  titlePrefix: 'Date Created',
                                  title: DateFormat('dd MMM yyyy, hh:mm a')
                                      .format(DateTime.parse(wallpaperCtrl
                                              .sanatanWallpaperList[index]
                                              .createdAt ??
                                          ""))),
                            ),

                            /// Wallpaper Type
                            Flexible(
                              flex: 1,
                              child: richTextMaker(
                                  isMobile: isMobile,
                                  iconName: Icons.accessibility_rounded,
                                  titlePrefix: 'Wallpaper Type',
                                  title: wallpaperCtrl
                                          .sanatanWallpaperList[index]
                                          .wallpaperType ??
                                      ""),
                            ),

                            /// god name
                            Flexible(
                              flex: 1,
                              child: richTextMaker(
                                  isMobile: isMobile,
                                  iconName: Icons.accessibility_rounded,
                                  titlePrefix: 'God Name',
                                  title: wallpaperCtrl
                                          .sanatanWallpaperList[index]
                                          .godName ??
                                      ""),
                            ),

                            /// download details
                            Row(
                              children: [
                                Flexible(
                                  flex: 1,
                                  child: richTextMaker(
                                      isMobile: isMobile,
                                      iconName: Icons.home,
                                      titlePrefix: 'Home Screen',
                                      title: wallpaperCtrl
                                          .sanatanWallpaperList[index]
                                          .homeScreen
                                          .toString()),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: richTextMaker(
                                      isMobile: isMobile,
                                      iconName: Icons.lock,
                                      titlePrefix: 'Lock Screen',
                                      title: wallpaperCtrl
                                          .sanatanWallpaperList[index]
                                          .lockScreen
                                          .toString()),
                                ),
                                Flexible(
                                  flex: 1,
                                  child: richTextMaker(
                                      isMobile: isMobile,
                                      iconName: Icons.download,
                                      titlePrefix: 'Both Screen',
                                      title: wallpaperCtrl
                                          .sanatanWallpaperList[index]
                                          .bothScreen
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
                                                              wallpaperCtrl.deleteCard(
                                                                  wallpaperCtrl
                                                                          .sanatanWallpaperList[
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
                                    icon: Icon(Icons.delete_forever,
                                        color: Colors.red))
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
