import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Postkaro/viewmodel/PostKaroCreationViewModel.dart';
import 'package:kamal_greet_web_2/Postkaro/viewmodel/PostKaroDashboardViewModel.dart';
import 'package:kamal_greet_web_2/Postkaro/viewmodel/SubCategoryViewModel.dart';
import 'package:kamal_greet_web_2/Postkaro/widgets/PostkaroDrawer.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CardListBuilder.dart';
import 'package:kamal_greet_web_2/Utils/widgets/CardListMandatories.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';

final SubCategoryViewModel subCategoryCtrl = Get.put(SubCategoryViewModel());
final PostKaroDashboardViewModel postKaroDashboardCtrl =
    Get.put(PostKaroDashboardViewModel());
final PostKaroCreationViewModel postKaroCreationCtrl =
    Get.put(PostKaroCreationViewModel());

class PostkaroDashboard extends StatefulWidget {
  const PostkaroDashboard({super.key});

  @override
  State<PostkaroDashboard> createState() => _PostkaroDashboardState();
}

class _PostkaroDashboardState extends State<PostkaroDashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  double sidebarPadding = 15;
  double sideButtonsRadius = 100;
  double sideButtonsTextSize = 16;
  FontWeight sideButtonWieght = FontWeight.w500;

  @override
  void initState() {
    postKaroDashboardCtrl.getCard('hi', forFilter: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
      return Obx(
        () => connectivityController.connectionType ==
                    MConnectivityResult.wifi ||
                connectivityController.connectionType ==
                    MConnectivityResult.mobile
            ? Scaffold(
                key: _scaffoldKey,
                backgroundColor: AppColors.creationScreenBackground,
                appBar: AppBar(
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                ),
                body: Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.center,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /// HEADER BUTTONS
                        Visibility(
                          visible: true,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 30),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.17,
                              decoration:
                                  const BoxDecoration(color: Colors.white),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  DynamicButton(
                                    leadingIcon: Icons.add,
                                    showLeading: true,
                                    radius: sideButtonsRadius,
                                    backgroundColor: AppColors.primaryColor,
                                    width: isMobile ? 80 : 150,
                                    text: 'addPost'.tr,
                                    boldness: sideButtonWieght,
                                    height: isMobile ? 26 : 46,
                                    textSize:
                                        isMobile ? 8 : sideButtonsTextSize,
                                    // onTap: () async {
                                    //   await GreetStorage.setTitle('');
                                    //   await GreetStorage.setColor('');
                                    //   await GreetStorage.setEndDate('');
                                    //   await GreetStorage.setShape('');
                                    //   await GreetStorage.setStartDate('');
                                    //   await GreetStorage.setSharingContent('');
                                    //   await GreetStorage.setOption('');
                                    //   await GreetStorage.setPhoto('');
                                    //   postKaroCreationCtrl.isEdited.value =
                                    //       false;
                                    //   postKaroCreationCtrl.startDate.value
                                    //       .clear();
                                    //   postKaroCreationCtrl.endDate.value
                                    //       .clear();
                                    //   postKaroCreationCtrl.titleController.value
                                    //       .clear();
                                    //   postKaroCreationCtrl
                                    //       .subCategoryCtrl.tagMapping.value
                                    //       .clear();
                                    //   postKaroCreationCtrl.subCategoryCtrl
                                    //       .fieldNameMapping.value
                                    //       .clear();
                                    //   postKaroCreationCtrl.sharingContent.value
                                    //       .clear();
                                    //   postKaroCreationCtrl.mainPostImage.value =
                                    //       '';
                                    //   subCategoryCtrl.idTag.value.clear();
                                    //   postKaroCreationCtrl
                                    //       .finalNamePlate.value = '';
                                    //   postKaroCreationCtrl
                                    //       .finalBackground.value = '';
                                    //   postKaroCreationCtrl
                                    //       .finalPartyLogo.value = '';
                                    //   postKaroCreationCtrl
                                    //       .finalPartyName.value = '';
                                    //   postKaroCreationCtrl
                                    //       .selectedNamePlate.value = -1;
                                    //   postKaroCreationCtrl.notifyUsers.value =
                                    //       false;
                                    //   postKaroCreationCtrl.notifyUsers
                                    //       .refresh();
                                    //   postKaroCreationCtrl.selectedAlignment
                                    //       .value = 'bottomLeft';
                                    //   postKaroCreationCtrl
                                    //       .selectedWishesPosition
                                    //       .value = 'topLeft';
                                    //   postKaroCreationCtrl.selectedShape.value =
                                    //       'circle';
                                    //   postKaroCreationCtrl.colorController.value
                                    //       .text = '0xFF000000';
                                    //   await GreetStorage.setId("");
                                    //
                                    //   /// NAVIGATING TO CREATION SCREEN
                                    //   ///BELOW IS THE OLD CREATION SCREEN
                                    //   // Get.to(CreatePostScreen(
                                    //   //   id: '',
                                    //   // ));
                                    //   /// NEW CREATION SCREEN
                                    //   Get.to(const CreationScreen(id: ''));
                                    // },
                                  ),
                                  SizedBox(
                                      height: isMobile ? 5 : sidebarPadding),
                                  DynamicButton(
                                    radius: sideButtonsRadius,
                                    backgroundColor: AppColors.yellowBg,
                                    width: isMobile ? 80 : 140,
                                    text: 'viewTag'.tr,
                                    textColor: AppColors.yellowText,
                                    boldness: sideButtonWieght,
                                    height: isMobile ? 26 : 36,
                                    textSize:
                                        isMobile ? 8 : sideButtonsTextSize,
                                    onTap: () {
                                      _scaffoldKey.currentState
                                          ?.openEndDrawer();
                                    },
                                  ),
                                  SizedBox(
                                      height: isMobile ? 5 : sidebarPadding),
                                  DynamicButton(
                                    radius: sideButtonsRadius,
                                    boldness: sideButtonWieght,
                                    backgroundColor: AppColors.yellowBg,
                                    width: isMobile ? 80 : 140,
                                    text: 'viewParty'.tr,
                                    textColor: AppColors.yellowText,
                                    height: isMobile ? 26 : 36,
                                    textSize:
                                        isMobile ? 8 : sideButtonsTextSize,
                                    onTap: () {
                                      postKaroDashboardCtrl
                                          .setStateByPartyStatus(
                                              Status.INITIAL);
                                      postKaroDashboardCtrl.getWebPartyList();
                                      postKaroDashboardCtrl.stateByPartyIdList =
                                          [];
                                      postKaroDashboardCtrl
                                          .parentPartyName.value = '';
                                      postKaroDashboardCtrl
                                          .parentPartyId.value = 0;
                                      // postKaroDashboardCtrl
                                      //     .parentPartyLogo.value = '';
                                      _scaffoldKey.currentState?.openDrawer();
                                    },
                                  ),
                                  SizedBox(
                                      height: isMobile ? 5 : sidebarPadding),
                                ],
                              ),
                            ),
                          ),
                        ),

                        /// LIST OF POSTS and BUTTONS
                        Expanded(
                          child: Column(
                            // crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(height: 20),

                              /// LANGUAGE

                              // Padding(
                              //   padding: const EdgeInsets.only(right: 80),
                              //   child: Row(
                              //     crossAxisAlignment: CrossAxisAlignment.start,
                              //     mainAxisAlignment: MainAxisAlignment.end,
                              //     children: [
                              //       SizedBox(
                              //           width:
                              //               MediaQuery.of(context).size.width *
                              //                   0.2,
                              //           child:
                              //               categorySelector(context, false)),
                              //       SizedBox(
                              //         width: 5,
                              //       ),
                              //       Padding(
                              //         padding: const EdgeInsets.only(right: 10),
                              //         child: SizedBox(
                              //           width:
                              //               MediaQuery.of(context).size.width *
                              //                   0.2,
                              //           child: Obx(() => DynamicDropdown(
                              //               length:
                              //                   dashCtr.languageNameList.length,
                              //               labelText: 'filterByLanguage'.tr,
                              //               selectedValue:
                              //                   dashCtr.languageName.value,
                              //               hintText: 'Hindi',
                              //               // hintText:
                              //               //     'filterByLanguage'.tr,
                              //               dropDownList:
                              //                   dashCtr.languageNameList,
                              //               onChange: (value) async {
                              //                 int selectedIndex = dashCtr
                              //                     .languageNameList
                              //                     .indexOf(value);
                              //
                              //                 await dashCtr.getTags(dashCtr
                              //                     .languageList[selectedIndex]
                              //                     .languageCode);
                              //                 String? tagId = '';
                              //                 bool forFilter = false;
                              //                 try {
                              //                   if (subCategoryCtrl.categorySelected
                              //                           .value ==
                              //                       'frame') {
                              //                     forFilter = false;
                              //                     tagId = '0';
                              //                   } else {
                              //                     tagId = dashCtr.tagList[0].id
                              //                         .toString();
                              //                     forFilter = true;
                              //                   }
                              //                 } catch (e) {}
                              //                 dashCtr.getCard(
                              //                     dashCtr
                              //                         .languageList[
                              //                             selectedIndex]
                              //                         .languageCode,
                              //                     forFilter: forFilter,
                              //                     tagId: tagId);
                              //                 dashCtr.selectedLanguage = dashCtr
                              //                     .languageList[selectedIndex]
                              //                     .languageCode;
                              //
                              //                 dashCtr.isShowTagFilter.value =
                              //                     true;
                              //                 dashCtr.isShowTagFilter.refresh();
                              //               })),
                              //         ),
                              //       ),
                              //       const Spacer(),
                              //       ongoingUpcomingTabs(
                              //         isMobile: isMobile,
                              //         onPress: () {
                              //           try {
                              //             dashCtr.getCard('hi',
                              //                 forFilter: false);
                              //             dashCtr.scrollController.jumpTo(0);
                              //           } catch (e) {}
                              //
                              //           dashCtr.toggleOngoingFilter("ONGOING");
                              //         },
                              //         tabName: "ONGOING",
                              //       ),
                              //       ongoingUpcomingTabs(
                              //         isMobile: isMobile,
                              //         onPress: () {
                              //           try {
                              //             dashCtr.getUpcomingCard(
                              //                 dashCtr.selectedLanguage,
                              //                 forFilter: false);
                              //             dashCtr.scrollController.jumpTo(0);
                              //           } catch (e) {}
                              //           dashCtr.toggleOngoingFilter("UPCOMING");
                              //         },
                              //         tabName: "UPCOMING",
                              //       )
                              //     ],
                              //   ),
                              // ),
                              // const SizedBox(height: 20),
                              // Align(
                              //   alignment: Alignment.centerLeft,
                              //   child: Visibility(
                              //     visible: (subCategoryCtrl.categorySelected.value ==
                              //             'post' &&
                              //         dashCtr.isShowTagFilter.value),
                              //     child: Padding(
                              //       padding: const EdgeInsets.only(bottom: 15),
                              //       child: creationSubTitle(
                              //           "Select Tag To filter",
                              //           SizedBox(
                              //             height: 30,
                              //             width: MediaQuery.of(context)
                              //                     .size
                              //                     .width *
                              //                 0.6,
                              //             child: ListView.separated(
                              //               separatorBuilder: (context, index) {
                              //                 return const SizedBox(width: 15);
                              //               },
                              //               scrollDirection: Axis.horizontal,
                              //               shrinkWrap: true,
                              //               itemCount: dashCtr.tagList.length,
                              //               itemBuilder: (context, index) {
                              //                 return buildTagsOption(
                              //                     dashCtr
                              //                         .tagList[index].tagName,
                              //                     index);
                              //               },
                              //             ),
                              //           )),
                              //     ),
                              //   ),
                              // ),

                              /// LIST OF POSTS
                              Obx(() {
                                switch (postKaroDashboardCtrl
                                    .rxRequestStatus.value) {
                                  case Status.INITIAL:
                                    return const SizedBox.shrink();
                                  case Status.COMPLETED:
                                    return Flexible(
                                      child: programListBuilder(isMobile,
                                          filteredList: postKaroDashboardCtrl
                                                  .listCards?.value ??
                                              []),
                                    );
                                  case Status.LOADING:
                                    return Flexible(child: shimmerCards());
                                  case Status.ERROR:
                                    return Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: 200,
                                            width: 200,
                                            child: Image.asset(
                                                'assets/images/error.png',
                                                width: 200,
                                                height: 200,
                                                fit: BoxFit.fill),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          title('error'.tr, isMobile),
                                        ],
                                      ),
                                    );
                                }
                              }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                drawer: PostKaroDrawer(isMobile: isMobile),
                endDrawer: Drawer(
                  width: isMobile
                      ? MediaQuery.of(context).size.width * 0.65
                      : MediaQuery.of(context).size.width * 0.45,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Flexible(
                                child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                title('tagList'.tr, isMobile),
                              ],
                            )),
                            Flexible(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Flexible(
                                    child: DynamicButton(
                                      width: isMobile ? 80 : 140,
                                      text: 'addTag'.tr,
                                      height: isMobile ? 26 : 36,
                                      textSize: isMobile ? 8 : 14,
                                      onTap: () {
                                        subCategoryCtrl.tagPhotos.value = '';
                                        subCategoryCtrl
                                            .tagNameController.value.text = '';
                                        showTagDialogue('');
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Flexible(
                                    child: DynamicButton(
                                      backgroundColor: AppColors.pink,
                                      width: isMobile ? 80 : 140,
                                      text: 'cancel'.tr,
                                      height: isMobile ? 26 : 36,
                                      textSize: isMobile ? 8 : 14,
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Obx(
                          () => Expanded(
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
                                      if (oldIndex != 0 && newIndex != 0) {
                                        setState(() {
                                          subCategoryCtrl.reorderTags(
                                              oldIndex, newIndex);
                                        });
                                      }
                                    },
                                    children: [
                                      for (int index = 0;
                                          index <
                                              subCategoryCtrl
                                                  .viewtagList.length;
                                          index += 1)
                                        Column(
                                          key: Key('$index'),
                                          children: [
                                            ListTile(
                                              contentPadding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 16.0),
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Text(
                                                        "${index + 1}.",
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: AppConstants
                                                              .titleSize,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 8),
                                                      // Adjust the spacing as needed
                                                      Text(
                                                        subCategoryCtrl
                                                            .tagList![index]!
                                                            .tagName,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: AppConstants
                                                              .titleSize,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  index == 0
                                                      ? const SizedBox.shrink()
                                                      : Row(
                                                          children: [
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.edit),
                                                              color: AppColors
                                                                  .pink,
                                                              onPressed: () {
                                                                subCategoryCtrl.setTag(
                                                                    tagName: subCategoryCtrl
                                                                        .tagList![
                                                                            index]!
                                                                        .tagName
                                                                        .toString(),
                                                                    tagLogo: subCategoryCtrl
                                                                        .tagList![
                                                                            index]!
                                                                        .tagImageurl
                                                                        .toString());
                                                                showTagDialogue(
                                                                    subCategoryCtrl
                                                                        .tagList![
                                                                            index]!
                                                                        .id
                                                                        .toString());
                                                              },
                                                            ),
                                                            IconButton(
                                                              icon: const Icon(
                                                                  Icons.delete),
                                                              color:
                                                                  Colors.black,
                                                              onPressed: () {
                                                                // Your delete button logic here
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                ],
                                              ),
                                              trailing: index == 0
                                                  ? const SizedBox.shrink()
                                                  : Obx(
                                                      () => Switch(
                                                        value: subCategoryCtrl
                                                            .isSelected(index),
                                                        onChanged: (value) {
                                                          subCategoryCtrl
                                                              .toggleSelection(
                                                                  index);
                                                        },
                                                      ),
                                                    ),
                                            ),
                                            const Divider(
                                              height: 1,
                                              thickness: 1,
                                              color: Colors.black12,
                                            ),
                                          ],
                                        ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            : const ConnectivityWidget(),
      );
    });
  }

  Future<void> showTagDialogue(String id) {
    return showDialog<void>(
        context: context,
        builder: ((context) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: Colors.white,
                ),
                width: 350,
                height: 280,
                child: Padding(
                    padding: const EdgeInsets.only(
                        top: 20, left: 20, right: 20, bottom: 10),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'addTagName'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: AppConstants.titleSize,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 80),
                            child: DynamicTextfield(
                              height: 45,
                              hintText: 'enterName'.tr,
                              controller:
                                  subCategoryCtrl.tagNameController.value,
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              DynamicButton(
                                backgroundColor: AppColors.pink,
                                text: "cancel".tr,
                                width: 100,
                                height: 30,
                                textSize: 14,
                                onTap: () {
                                  Navigator.pop(context);
                                },
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              id == ''
                                  ? DynamicButton(
                                      text: 'submit'.tr,
                                      width: 100,
                                      height: 30,
                                      textSize: 14,
                                      onTap: () {
                                        subCategoryCtrl.createTag();
                                        Navigator.pop(context);
                                      },
                                    )
                                  : DynamicButton(
                                      text: 'update'.tr,
                                      width: 100,
                                      height: 30,
                                      textSize: 14,
                                      onTap: () {},
                                    ),
                            ],
                          ),
                        ])),
              ),
            ),
          );
        }));
  }
}
