
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/StateByPartyIdModel.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/SingleLanguageSelector.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicDropdown.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/dashboard/view/DashboardScreen.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/foundation.dart';

class PostKaroDrawer extends StatefulWidget {
  final bool isMobile;

  const PostKaroDrawer({super.key, required this.isMobile});

  @override
  State<PostKaroDrawer> createState() => _PostKaroDrawerState();
}

class _PostKaroDrawerState extends State<PostKaroDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: widget.isMobile
          ? MediaQuery.of(context).size.width * 0.5
          : MediaQuery.of(context).size.width * 0.45,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_new,
                      size: 20,
                    )),
                title('partyList'.tr, widget.isMobile),
                const Spacer(),

                /// add party button
                DynamicButton(
                  width: widget.isMobile ? 80 : 140,
                  text: 'addParty'.tr,
                  height: widget.isMobile ? 26 : 36,
                  textSize: widget.isMobile ? 8 : 12,
                  onTap: () {
                    postKaroDashboardCtrl.clearParty();
                    showPartyDialog(0);
                  },
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Divider(height: 1),
            const SizedBox(height: 10),

            /// party list dropdown
            Text(
              'state'.tr,
              style: GoogleFonts.poppins(
                  fontSize: AppConstants.titleSize,
                  fontWeight: FontWeight.w400),
            ),
            const SizedBox(height: 10),
            Obx(() {
              return Padding(
                padding: const EdgeInsets.only(right: 80),
                child: DynamicDropdown(
                    length: postKaroDashboardCtrl.partyNameList.length,
                    selectedValue: postKaroDashboardCtrl.parentPartyName.value,
                    hintText: 'selectParty'.tr,
                    dropDownList: postKaroDashboardCtrl.partyNameList,
                    onChange: (value) {
                      int selectedIndex =
                          postKaroDashboardCtrl.partyNameList.indexOf(value);
                      postKaroDashboardCtrl.parentPartyId.value =
                          postKaroDashboardCtrl
                              .partyList[selectedIndex].partyId;
                      postKaroDashboardCtrl.parentPartyName.value =
                          postKaroDashboardCtrl.partyNameList[selectedIndex];
                      postKaroDashboardCtrl.getStateByPartyId(
                          postKaroDashboardCtrl.parentPartyId.value);
                    }),
              );
            }),
            const SizedBox(height: 10),

            /// state party list and member list
            Obx(() {
              switch (postKaroDashboardCtrl.stateByPartyStatus.value) {
                case Status.INITIAL:
                  return const SizedBox.shrink();
                case Status.COMPLETED:
                  if (postKaroDashboardCtrl.stateByPartyIdList.isEmpty) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Center(
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
                      ),
                    );
                  }
                  List<StateByPartyIdDatum> sortedList =
                      List.from(postKaroDashboardCtrl.stateByPartyIdList)
                        ..sort((a, b) => a.stateName.compareTo(b.stateName));
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: Colors.black12,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListView(
                        children: [
                          ReorderableListView(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            onReorder: (oldIndex, newIndex) {
                              setState(() {
                                postKaroDashboardCtrl.reorderParty(
                                    oldIndex, newIndex);
                              });
                            },
                            children: [
                              for (int index = 0;
                                  index < sortedList.length;
                                  index += 1)
                                Column(
                                  key: Key('$index'),
                                  children: [
                                    ExpansionTile(
                                      title: Text(
                                        sortedList[index].stateName,
                                        style: GoogleFonts.poppins(
                                          fontSize: AppConstants.titleSize2,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      trailing: const SizedBox(),
                                      children: [
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              'partyMember'.tr,
                                              style: GoogleFonts.poppins(
                                                fontSize:
                                                    AppConstants.titleSize2,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 5,
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: IconButton(
                                                icon: const Icon(Icons.edit),
                                                color: AppColors.pink,
                                                onPressed: () {
                                                  postKaroDashboardCtrl
                                                      .partyListIdForUpdation
                                                      .value = sortedList[
                                                          index]
                                                      .id;
                                                  postKaroDashboardCtrl.setParty(
                                                      nameOfState:
                                                          sortedList[index]
                                                              .stateName,
                                                      idOfState:
                                                          sortedList[index]
                                                              .stateId,
                                                      nameOfParty:
                                                          postKaroDashboardCtrl
                                                              .parentPartyName
                                                              .value,
                                                      idOfParty:
                                                          postKaroDashboardCtrl
                                                              .parentPartyId
                                                              .value,
                                                      logo: sortedList[index]
                                                          .partylogo,
                                                      membersList:
                                                          sortedList[index]
                                                              .partyMemberlist);

                                                  showPartyDialog(
                                                      postKaroDashboardCtrl
                                                          .partyListIdForUpdation
                                                          .value);
                                                },
                                              ),
                                            ),
                                            Visibility(
                                              visible: true,
                                              child: IconButton(
                                                icon: const Icon(
                                                  Icons.delete,
                                                ),
                                                color: Colors.black,
                                                onPressed: () {
                                                  showDialog<void>(
                                                      context: context,
                                                      builder: ((context) {
                                                        return Center(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10),
                                                            child: Container(
                                                              decoration:
                                                                  const BoxDecoration(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            10)),
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              width: 400,
                                                              height: 150,
                                                              child: Padding(
                                                                  padding: const EdgeInsets
                                                                      .only(
                                                                      top: 20,
                                                                      left: 20,
                                                                      right: 20,
                                                                      bottom:
                                                                          10),
                                                                  child: Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                          'deleteParty'
                                                                              .tr,
                                                                          style:
                                                                              GoogleFonts.poppins(
                                                                            fontSize:
                                                                                AppConstants.titleSize2,
                                                                            fontWeight:
                                                                                FontWeight.w400,
                                                                          ),
                                                                        ),
                                                                        const SizedBox(
                                                                          height:
                                                                              20,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.end,
                                                                          children: [
                                                                            DynamicButton(
                                                                              backgroundColor: AppColors.pink,
                                                                              text: 'yes'.tr,
                                                                              width: 100,
                                                                              height: 30,
                                                                              textSize: 14,
                                                                              onTap: () {
                                                                                postKaroDashboardCtrl.deleteParty(sortedList[index].id);
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                            const SizedBox(
                                                                              width: 5,
                                                                            ),
                                                                            DynamicButton(
                                                                              text: 'no'.tr,
                                                                              width: 100,
                                                                              height: 30,
                                                                              textSize: 14,
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ])),
                                                            ),
                                                          ),
                                                        );
                                                      }));
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        sortedList[index]
                                                .partyMemberlist
                                                .isNotEmpty
                                            ? SizedBox(
                                                height: 60,
                                                child: ListView.builder(
                                                  scrollDirection:
                                                      Axis.horizontal,
                                                  itemCount: sortedList[index]
                                                      .partyMemberlist
                                                      .length,
                                                  itemBuilder:
                                                      (context, memberIndex) {
                                                    return Row(
                                                      children: [
                                                        const SizedBox(
                                                          width: 15,
                                                        ),
                                                        SizedBox(
                                                          height: 40,
                                                          width: 40,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        100),
                                                            child:
                                                                Image.network(
                                                              sortedList[index]
                                                                      .partyMemberlist[
                                                                  memberIndex],
                                                              // height: 40,
                                                              // width: 40,
                                                              fit: BoxFit.cover,
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  const Icon(Icons
                                                                      .image),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              )
                                            : const Text('No Members'),
                                        const SizedBox(
                                          height: 15,
                                        )
                                      ],
                                    ),
                                    const Divider(
                                      height: 1,
                                      thickness: 1,
                                      color: Colors.black12,
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                case Status.LOADING:
                  return const Center(child: CircularProgressIndicator());
                case Status.ERROR:
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 200,
                          width: 200,
                          child: Image.asset('assets/images/error.png',
                              width: 200, height: 200, fit: BoxFit.fill),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        title('error'.tr, widget.isMobile),
                      ],
                    ),
                  );
              }
            }),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget title(String title, final isMobile) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: isMobile ? AppConstants.titleSize : AppConstants.titleSize2,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Future<void> showPartyDialog(int id) {
    postKaroDashboardCtrl.getStateList();
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
                            // Row(),
                            // Text(
                            //   'addNewParty'.tr,
                            //   style: GoogleFonts.poppins(
                            //     fontSize: KamalDimensions.titleSize,
                            //     fontWeight: FontWeight.w600,
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 10,
                            // ),
                            // Padding(
                            //   padding: const EdgeInsets.only(right: 80),
                            //   child: DynamicTextfield(
                            //     height: 45,
                            //     hintText: 'enterPartyName'.tr,
                            //     controller: postKaroDashboardCtrl.partyNameController.value,
                            //   ),
                            // ),
                            // const SizedBox(
                            //   height: 20,
                            // ),

                            /// PARTY DROPDOWN
                            Text(
                              'party'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: AppConstants.titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: DynamicDropdown(
                                    length: postKaroDashboardCtrl
                                        .partyNameList.length,
                                    labelText: 'selectParty'.tr,
                                    selectedValue:
                                        postKaroDashboardCtrl.partyName.value,
                                    hintText: 'selectParty'.tr,
                                    dropDownList:
                                        postKaroDashboardCtrl.partyNameList,
                                    onChange: (value) {
                                      int selectedIndex = postKaroDashboardCtrl
                                          .partyNameList
                                          .indexOf(value);
                                      postKaroDashboardCtrl.partyName.value =
                                          postKaroDashboardCtrl
                                              .partyNameList[selectedIndex];
                                      postKaroDashboardCtrl.partyId.value =
                                          postKaroDashboardCtrl
                                              .partyList[selectedIndex].partyId;
                                      postKaroDashboardCtrl.partyLogo.value =
                                          postKaroDashboardCtrl
                                              .partyList[selectedIndex]
                                              .partyLogo
                                              .toString();
                                      postKaroDashboardCtrl.logoPhoto.value =
                                          postKaroDashboardCtrl.partyLogo.value;
                                    }),
                              );
                            }),
                            const SizedBox(
                              height: 10,
                            ),

                            /// STATE SELECTOR
                            Text(
                              'state'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: AppConstants.titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            const SizedBox(
                              height: 10,
                            ),
                            Obx(() {
                              return Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: DynamicDropdown(
                                    length: postKaroDashboardCtrl
                                        .stateNamesList.length,
                                    labelText: 'selectState'.tr,
                                    selectedValue:
                                        postKaroDashboardCtrl.stateName.value,
                                    hintText: 'selectState'.tr,
                                    dropDownList:
                                        postKaroDashboardCtrl.stateNamesList,
                                    onChange: (value) {
                                      int selectedIndex = postKaroDashboardCtrl
                                          .stateNamesList
                                          .indexOf(value);
                                      postKaroDashboardCtrl.stateName.value =
                                          postKaroDashboardCtrl
                                              .stateNamesList[selectedIndex];
                                      postKaroDashboardCtrl.stateId.value =
                                          postKaroDashboardCtrl
                                              .stateList[selectedIndex].id;
                                    }),
                              );
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                                padding: const EdgeInsets.only(right: 80),
                                child: singleLanguageSelector()),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'uploadLogo'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: AppConstants.titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /// PARTY LOGO
                            Obx(() {
                              if (logoPickerCtrl.isLoadingLogo.value) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.2),
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFA5A8),
                                          Color(0xFFFFE3F6),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Text('jhghjkl'),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: GestureDetector(
                                    onTap: () {
                                      logoPickerCtrl.pickLogo(
                                          isFromPoojaThumbnail: false,
                                          isFromGuruVani: false,
                                          isFromSanatanGod: false);
                                    },
                                    child: Container(
                                      color: Colors.white,
                                      height: 100,
                                      width: 100,
                                      child: postKaroDashboardCtrl
                                                  .logoPhoto.value ==
                                              ""
                                          ? noPartyLogoWidget('addLogo'.tr)
                                          : Stack(
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      const BorderRadius.all(
                                                          Radius.circular(20)),
                                                  child: Image.network(
                                                    postKaroDashboardCtrl
                                                        .logoPhoto.value,
                                                    height: 100,
                                                    width: 100,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Center(
                                                        child: Icon(
                                                          Icons.image,
                                                          size: 75,
                                                          color:
                                                              AppColors.teal50,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                                Positioned(
                                                  top: -8,
                                                  right: -8,
                                                  child: IconButton(
                                                    onPressed: () {
                                                      postKaroDashboardCtrl
                                                          .removeLogo();
                                                    },
                                                    icon: Container(
                                                      decoration: BoxDecoration(
                                                        border: Border.all(
                                                          width: 0.5,
                                                          color:
                                                              AppColors.teal50,
                                                        ),
                                                        shape: BoxShape.circle,
                                                        color: const Color(
                                                            0xFFDC7AA9),
                                                      ),
                                                      child: Center(
                                                        child: Icon(
                                                          Icons.close,
                                                          color: AppColors
                                                              .whiteCard,
                                                          size: 10,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                    ),
                                  ),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                              'addMemberList'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: AppConstants.titleSize,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),

                            /// MEMBER LIST
                            Obx(() {
                              if (postKaroDashboardCtrl.isLoadingMore.value) {
                                return Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(0.2),
                                  highlightColor: Colors.grey.withOpacity(0.1),
                                  child: Container(
                                    height: 100,
                                    width: 100,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFFFFA5A8),
                                          Color(0xFFFFE3F6),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(12)),
                                    ),
                                    child: const Padding(
                                      padding: EdgeInsets.all(15),
                                      child: SizedBox(
                                        height: 100,
                                        width: 100,
                                        child: Text('jhghjkl'),
                                      ),
                                    ),
                                  ),
                                );
                              } else {
                                return Container(
                                  color: Colors.white,
                                  height: 100,
                                  child: ReorderableListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: postKaroDashboardCtrl
                                            .partyMember.length +
                                        1,
                                    onReorder: (oldIndex, newIndex) {
                                      if (oldIndex != postKaroDashboardCtrl.partyMember.length &&
                                          newIndex !=
                                              postKaroDashboardCtrl
                                                  .partyMember.length &&
                                          newIndex !=
                                              postKaroDashboardCtrl
                                                      .partyMember.length +
                                                  1) {
                                        postKaroDashboardCtrl
                                            .reorderPartyMembers(
                                                oldIndex, newIndex);
                                      }
                                    },
                                    itemBuilder: (context, index) {
                                      if (index ==
                                          postKaroDashboardCtrl
                                              .partyMember.length) {
                                        return ReorderableDragStartListener(
                                          key: ValueKey(index),
                                          index: index,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              GestureDetector(
                                                onTap: () async {
                                                  if (postKaroDashboardCtrl
                                                          .partyMember.length <
                                                      5) {
                                                    Future<Uint8List?>
                                                        galleryImagePicker() async {
                                                      ImagePicker picker =
                                                          ImagePicker();
                                                      XFile? file = await picker
                                                          .pickImage(
                                                        source:
                                                            ImageSource.gallery,
                                                        imageQuality: 90,
                                                      );
                                                      if (file != null) {
                                                        return await file
                                                            .readAsBytes();
                                                      }
                                                      return null;
                                                    }

                                                    Uint8List? selectedImage =
                                                        await galleryImagePicker();
                                                    if (selectedImage != null) {
                                                      postKaroDashboardCtrl
                                                          .uploadToFirebasePhoto(
                                                              selectedImage);
                                                    }
                                                  } else {
                                                    EasyLoading.showError(
                                                        'maxLimit'.tr);
                                                  }
                                                },
                                                child: noPartyLogoWidget(
                                                    'addMember'.tr),
                                              ),
                                            ],
                                          ),
                                        );
                                      } else {
                                        return ReorderableDragStartListener(
                                          key: ValueKey(index),
                                          index: index,
                                          child: Row(
                                            children: [
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              buildImageWidget(index),
                                            ],
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              }
                            }),
                            const SizedBox(
                              height: 20,
                            ),

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
                                    if (postKaroDashboardCtrl.partyName.value ==
                                            '' ||
                                        postKaroDashboardCtrl
                                            .partyName.value.isEmpty) {
                                      EasyLoading.showError('Select Party');
                                      return;
                                    } else if (postKaroDashboardCtrl
                                            .stateId.value ==
                                        0) {
                                      EasyLoading.showError('Select State');
                                      return;
                                    } else if (postKaroDashboardCtrl
                                        .partyMember.isEmpty) {
                                      EasyLoading.showError('Select Members');
                                      return;
                                    } else if (postKaroDashboardCtrl
                                        .partyListSelectedLanguage.isEmpty) {
                                      EasyLoading.showError('Select Language');
                                      return;
                                    } else if (postKaroDashboardCtrl
                                            .partyListIdForUpdation.value ==
                                        0) {
                                      postKaroDashboardCtrl.createParty();
                                    } else {
                                      postKaroDashboardCtrl.updateParty();
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
                                      postKaroDashboardCtrl
                                                  .partyListIdForUpdation
                                                  .value ==
                                              0
                                          ? 'submit'.tr
                                          : 'update'.tr,
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

  Widget buildImageWidget(int index) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          child: Image.network(
            postKaroDashboardCtrl.partyMember[index],
            height: 100,
            width: 100,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                const Icon(Icons.image),
          ),
        ),
        Positioned(
          top: -8,
          right: -8,
          child: IconButton(
            onPressed: () {
              postKaroDashboardCtrl.partyMember.removeAt(index);
            },
            icon: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  width: 0.5,
                  color: AppColors.teal50,
                ),
                shape: BoxShape.circle,
                color: const Color(0xFFDC7AA9),
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  color: AppColors.whiteCard,
                  size: 10,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
