import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kamal_greet_web_2/Postkaro/data/model/DashModel.dart';
import 'package:kamal_greet_web_2/Postkaro/view/PostkaroDashboard.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import '../../../Utils/values/AppConstants.dart';
import '../../../Utils/widgets/DynamicButton.dart';

class GreetingsCard extends StatefulWidget {
  final String name;
  final List<int> tag;
  final String image;
  final String status;
  final String id;
  final int index;
  final int sharedCount;
  final int downloadCount;
  final bool isPinned;
  var isMobile;
  var startDate;
  var endDate;
  var createdAt;
  var isPosition;
  var isShape;
  var postType;

  // bool isSelected;

  GreetingsCard({
    super.key,
    required this.name,
    required this.postType,
    required this.isPosition,
    required this.isShape,
    required this.isMobile,
    required this.tag,
    required this.image,
    required this.status,
    required this.id,
    required this.index,
    required this.sharedCount,
    required this.downloadCount,
    required this.isPinned,
    required this.startDate,
    required this.endDate,
    required this.createdAt,
    // required this.isSelected,
  });

  @override
  State<GreetingsCard> createState() => _GreetingsCardState();
}

class _GreetingsCardState extends State<GreetingsCard> {
  Uint8List? thumbnailBytes;

  @override
  void initState() {
    super.initState();
    if (widget.postType == PostType.VIDEO) {
      _generateThumbnail();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> _generateThumbnail() async {
    final videoElement = html.VideoElement()
      ..src = widget.image
      ..autoplay = true
      ..muted = true
      ..crossOrigin = 'anonymous';

    await videoElement.onLoadedData.first;

    final canvas = html.CanvasElement(
      width: videoElement.videoWidth,
      height: videoElement.videoHeight,
    );

    final context = canvas.context2D;

    context.drawImage(videoElement, 0, 0);

    final dataUrl = canvas.toDataUrl('image/jpeg');

    final blob = html.Blob([
      Uint8List.fromList(html.window.atob(dataUrl.split(',')[1]).codeUnits)
    ]);

    final reader = html.FileReader();

    reader.onLoad.first.then((_) {
      final uint8List = Uint8List.fromList(reader.result as List<int>);
      setState(() {
        thumbnailBytes = uint8List;
      });
    }).catchError((error) {
      if (kDebugMode) {
        print('Error loading thumbnail: $error');
      }
    });

    reader.readAsArrayBuffer(blob);
  }

  @override
  Widget build(BuildContext context) {
    double cardRadius = 10;
    List<String> tagIds = widget.tag.map((id) => id.toString()).toList();

    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.4,
      height: MediaQuery.of(context).size.height * 0.32,
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 1,
                child: Container(
                  width: widget.isMobile
                      ? 150
                      : MediaQuery.of(context).size.width * 0.13,
                  height: widget.isMobile
                      ? 150
                      : MediaQuery.of(context).size.width * 0.18,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.grey.shade700, width: 0.5),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(cardRadius),
                        bottomLeft: Radius.circular(cardRadius)),
                  ),
                  child: widget.image == ""
                      ? Center(
                          child: Icon(
                            Icons.image,
                            size: 80,
                            color: AppColors.teal50,
                          ),
                        )
                      : widget.postType == PostType.VIDEO
                          ? thumbnailBytes != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(cardRadius),
                                      bottomLeft: Radius.circular(cardRadius)),
                                  child: Image.memory(
                                    thumbnailBytes!,
                                    fit: BoxFit.fill,
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
                                )
                              : const SizedBox.shrink()
                          : ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(cardRadius),
                                  bottomLeft: Radius.circular(cardRadius)),
                              child: Image.network(
                                widget.image,
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
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(cardRadius),
                        bottomRight: Radius.circular(cardRadius)),
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
                                        widget.name,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.poppins(
                                          fontSize: widget.isMobile ? 12 : 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              /// START DATE
                              Flexible(
                                flex: 1,
                                child: richTextMaker(
                                    Icons.calendar_month,
                                    'Start Date',
                                    formatDateString(widget.startDate)),
                              ),

                              /// CREATED DATE
                              Flexible(
                                flex: 1,
                                child: richTextMaker(
                                    Icons.calendar_month,
                                    'Date Created',
                                    DateFormat('dd MMM yyyy, hh:mm a').format(
                                        DateTime.parse(widget.createdAt))),
                              ),

                              /// SHARE, DOWNLOAD COUNT & POST ID
                              rowMaker([
                                richTextMaker(Icons.share, 'Share Count',
                                    widget.sharedCount.toString()),
                                const SizedBox(
                                  width: 5,
                                ),
                                richTextMaker(Icons.download, 'Download Count',
                                    widget.downloadCount.toString()),
                                const SizedBox(
                                  width: 5,
                                ),
                                richTextMaker(Icons.numbers_rounded, 'Post Id',
                                    widget.id),
                              ]),

                              const SizedBox(
                                height: 5,
                              ),
                              Flexible(
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'tag:'.tr,
                                      style: GoogleFonts.poppins(
                                        fontSize: widget.isMobile ? 14 : 16,
                                        fontWeight: FontWeight.w400,
                                        color: Colors.black,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Expanded(
                                      child: Wrap(
                                        spacing: 6,
                                        runSpacing: 3,
                                        children: () {
                                          final tagList = subCategoryCtrl
                                              .getKeysFromTagIds(tagIds);

                                          return tagList
                                              .asMap()
                                              .entries
                                              .map((entry) {
                                            final index = entry.key;
                                            final tagname = entry.value;

                                            if (index < 3) {
                                              return Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: AppColors.teal50,
                                                  // border: Border.all(
                                                  //   width: 1,
                                                  //   color: Colors.grey,
                                                  // ),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                child: Text(
                                                  tagname.toString(),
                                                  style: GoogleFonts.poppins(
                                                    fontSize: widget.isMobile
                                                        ? 8
                                                        : 10,
                                                    fontWeight: FontWeight.w400,
                                                    color:
                                                        AppColors.primaryColor,
                                                  ),
                                                ),
                                              );
                                            } else if (index == 3) {
                                              final remainingCount =
                                                  tagList.length - 3;

                                              return Container(
                                                constraints: BoxConstraints(
                                                  maxWidth:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          2,
                                                ),
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 4,
                                                        vertical: 4),
                                                decoration: BoxDecoration(
                                                  color: AppColors.primaryColor,
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: Text(
                                                  '+$remainingCount more',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: widget.isMobile
                                                        ? 6
                                                        : 10,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              );
                                            } else {
                                              return const SizedBox.shrink();
                                            }
                                          }).toList();
                                        }(),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 0,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: EditDeleteButtons(
                              cardRadius: cardRadius,
                              id: widget.id,
                              isMobile: widget.isMobile,
                              index: widget.index,
                              isPinned: widget.isPinned,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String formatDateString(String dateString) {
    try {
      final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
      final parsedDate = dateFormat.parse(dateString);
      final formattedDate =
          DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
      return formattedDate;
    } catch (e) {
      return '';
    }
  }

  Flexible rowMaker(List<Widget> child) {
    return Flexible(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: child,
    ));
  }

  Align richTextMaker(IconData iconName, String titlePrefix, String title) {
    return Align(
      alignment: Alignment.centerLeft, // Align the Container to the left
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: Colors.grey.shade200),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
          child: Row(
            mainAxisSize:
                MainAxisSize.min, // Make Row only as wide as its content
            children: [
              Icon(
                iconName,
                size: widget.isMobile ? 14 : 18,
                color: Colors.grey.withOpacity(0.6),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 5),
                child: RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '$titlePrefix: ',
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 12 : 14,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey.withOpacity(0.6),
                        ),
                      ),
                      TextSpan(
                        text: title,
                        style: GoogleFonts.poppins(
                          fontSize: widget.isMobile ? 12 : 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget avatarImage() {
    return Container(
        height: 50,
        width: 50,
        decoration: BoxDecoration(
          color: AppColors.teal50,
          border: Border.all(width: 1, color: AppColors.primaryColor),
          borderRadius: widget.isShape == 'square'
              ? BorderRadius.circular(5)
              : BorderRadius.circular(50),
        ),
        child: Icon(
          Icons.person,
          size: 40,
          color: AppColors.primaryColor,
        ));
  }
}

class EditDeleteButtons extends StatefulWidget {
  final bool isMobile;
  final String id;
  final double cardRadius;
  final int index;
  final bool isPinned;

  const EditDeleteButtons({
    super.key,
    required this.isMobile,
    required this.id,
    required this.cardRadius,
    required this.index,
    required this.isPinned,
  });

  @override
  _EditDeleteButtonsState createState() => _EditDeleteButtonsState();
}

class _EditDeleteButtonsState extends State<EditDeleteButtons> {
  bool _isEditHovered = false;
  bool _isDeleteHovered = false;

  @override
  Widget build(BuildContext context) {
    double noHoverWidth = widget.isMobile ? MediaQuery.of(context).size.width * 0.01 : MediaQuery.of(context).size.width * 0.04;
    double height = widget.isMobile ? MediaQuery.of(context).size.width * 0.01 : MediaQuery.of(context).size.width * 0.04;
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              bool pinValue = false;
              pinValue = !widget.isPinned;
              postKaroDashboardCtrl.callPinPostApi(widget.id, pinValue);
            },
            child: Container(
              width: noHoverWidth,
              height: height,
              decoration: BoxDecoration(
                color: widget.isPinned ? AppColors.primaryColor : Colors.white,
                border:
                    Border.all(width: 0.5, color: AppColors.deleteEditButton),
                borderRadius: BorderRadius.circular(widget.cardRadius),
              ),
              child: SizedBox(
                  width: widget.isMobile ? 12 : 25,
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      widget.isPinned
                          ? 'assets/images/pinned_true.png'
                          : 'assets/images/pinned_false.png',
                      width: widget.isMobile ? 12 : 25,
                    ),
                  )),
            ),
          ),
        ),
        const SizedBox(height: 10),
        Obx(
          () => Flexible(
            flex: 1,
            child: GestureDetector(
              // onTap: () {
              //   postKaroCreationCtrl.setCardData(
              //     startDates: dashCtr.listCards![widget.index]?.startDate,
              //     endDates: dashCtr.listCards![widget.index]?.endDate,
              //     title: dashCtr.listCards![widget.index]?.title,
              //     categoryList:
              //         dashCtr.listCards![widget.index]?.categoryList ?? [],
              //     subCategoryList:
              //         dashCtr.listCards![widget.index]?.tagList ?? [],
              //     sharingContents:
              //         dashCtr.listCards![widget.index]?.sharingContent,
              //     contentUrl: dashCtr.listCards![widget.index]?.postUrl,
              //     avatarPosition:
              //         dashCtr.listCards![widget.index]?.avatarPostion,
              //     wishesPosition: '',
              //   );
              //   postKaroCreationCtrl.isEdited.value = true;
              //   postKaroCreationCtrl.notifyUsers.value = false;
              //   postKaroCreationCtrl.notifyUsers.refresh();
              //
              //   String? id = dashCtr.listCards![widget.index]?.id.toString();
              //
              //   /// EDIT CREATION SCREEN
              //   Get.to(CreationScreen(id: id));
              // },
              child: MouseRegion(
                onEnter: (_) => setState(() => _isEditHovered = true),
                onExit: (_) => setState(() => _isEditHovered = false),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: noHoverWidth,
                  height: height,
                  decoration: BoxDecoration(
                    color: AppColors.whiteCard,
                    border: Border.all(
                        width: 0.5, color: AppColors.deleteEditButton),
                    borderRadius: BorderRadius.circular(widget.cardRadius),
                  ),
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: !_isEditHovered,
                          child: Icon(
                            Icons.edit,
                            size: widget.isMobile ? 12 : 25,
                            color: AppColors.deleteEditButton,
                          ),
                        ),
                        AnimatedOpacity(
                          opacity: _isEditHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: SizedBox(width: _isEditHovered ? 4 : 0),
                        ),
                        AnimatedOpacity(
                          opacity: _isEditHovered ? 1.0 : 0.0,
                          duration: const Duration(milliseconds: 300),
                          child: Visibility(
                            visible: _isEditHovered,
                            child: Text(
                              'edit'.tr,
                              style: GoogleFonts.poppins(
                                fontSize: widget.isMobile ? 8 : 14,
                                fontWeight: FontWeight.w500,
                                color: AppColors.deleteEditButton,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            child: MouseRegion(
              onEnter: (_) => setState(() => _isDeleteHovered = true),
              onExit: (_) => setState(() => _isDeleteHovered = false),
              child: Container(
                width: noHoverWidth,
                height: height,
                decoration: BoxDecoration(
                  color: AppColors.whiteCard,
                  border:
                      Border.all(width: 0.5, color: AppColors.deleteEditButton),
                  borderRadius: BorderRadius.circular(widget.cardRadius),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Visibility(
                        visible: !_isDeleteHovered,
                        child: Icon(
                          Icons.delete,
                          size: widget.isMobile ? 12 : 25,
                          color: AppColors.deleteEditButton,
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: _isDeleteHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Visibility(
                            visible: _isDeleteHovered,
                            child: SizedBox(width: _isDeleteHovered ? 4 : 0)),
                      ),
                      AnimatedOpacity(
                        opacity: _isDeleteHovered ? 1.0 : 0.0,
                        duration: const Duration(milliseconds: 300),
                        child: Visibility(
                          visible: _isDeleteHovered,
                          child: Text(
                            'delete'.tr,
                            style: GoogleFonts.poppins(
                              fontSize: widget.isMobile ? 8 : 14,
                              fontWeight: FontWeight.w600,
                              color: AppColors.deleteEditButton,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            onTap: () {
              showDialog<void>(
                context: context,
                builder: (context) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: Colors.white,
                        ),
                        width: 400,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20, left: 20, right: 20, bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'deleteCard'.tr,
                                style: GoogleFonts.poppins(
                                  fontSize: AppConstants.titleSize2,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  DynamicButton(
                                    backgroundColor: AppColors.deleteEditButton,
                                    text: 'yes'.tr,
                                    width: 100,
                                    height: 30,
                                    textSize: 14,
                                    onTap: () {
                                      postKaroDashboardCtrl
                                          .deleteCard(int.parse(widget.id));
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(width: 5),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Flexible(
          flex: 1,
          child: GestureDetector(
            onTap: () {
              EasyLoading.showInfo(
                  'Notify Users About This Post Coming Soon...');
            },
            child: Container(
              width: noHoverWidth,
              height: height,
              decoration: BoxDecoration(
                color: AppColors.whiteCard,
                border:
                    Border.all(width: 0.5, color: AppColors.deleteEditButton),
                borderRadius: BorderRadius.circular(widget.cardRadius),
              ),
              child: Icon(
                Icons.notifications_active,
                size: widget.isMobile ? 12 : 25,
                color: AppColors.deleteEditButton,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
