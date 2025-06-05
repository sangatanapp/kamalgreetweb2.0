import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/viewmodel/PoojaDetailsViewModel.dart';
import 'package:kamal_greet_web_2/sanatan/pooja/widgets/PoojaBenefitsWidget.dart';
import 'package:kamal_greet_web_2/sanatan/wallpaper/view/AddWallpaperScreen.dart';

final PoojaDetailsViewModel poojaDetailsCtrl = Get.put(PoojaDetailsViewModel());

class AddPoojaDetails extends StatefulWidget {
  final int? index;
  final int? poojaId;

  const AddPoojaDetails({super.key, this.poojaId, this.index});

  @override
  State<AddPoojaDetails> createState() => _AddPoojaDetailsState();
}

class _AddPoojaDetailsState extends State<AddPoojaDetails> {
  @override
  void initState() {
    poojaDetailsCtrl.getPoojaDetails(
        whichTab: poojaDetailsCtrl.poojaDetailsTab[0].toString().toLowerCase(),
        poojaId: widget.poojaId ?? 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () => connectivityController.connectionType == MConnectivityResult.wifi ||
            connectivityController.connectionType == MConnectivityResult.mobile
            ? PopScope(
                child: Scaffold(
                  appBar: AppBar(
                    leading: InkWell(
                        onTap: () => Get.back(),
                        child:
                            const Icon(Icons.arrow_back, color: Colors.black)),
                    centerTitle: true,
                    title: Text(
                      "Pooja Benefits",
                      style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontSize: 40,
                          fontWeight: FontWeight.w600),
                    ),
                    backgroundColor: Colors.white,
                  ),
                  backgroundColor: AppColors.creationScreenBackground,
                  body: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Center(
                        //   child: SizedBox(
                        //     height: 90,
                        //     child: ListView.builder(
                        //       scrollDirection: Axis.horizontal,
                        //       shrinkWrap: true,
                        //       itemCount:
                        //           poojaDetailsCtrl.poojaDetailsTab.length,
                        //       itemBuilder: (context, index) {
                        //         return Padding(
                        //           padding: const EdgeInsets.all(20),
                        //           child: InkWell(
                        //             onTap: () {
                        //               poojaDetailsCtrl.poojaDetailsData.clear();
                        //               poojaDetailsCtrl.selectedTabIndex.value =
                        //                   index;
                        //               poojaDetailsCtrl.selectedTabIndex
                        //                   .refresh();
                        //               (index != 1)
                        //                   ? poojaDetailsCtrl.getPoojaDetails(
                        //                       whichTab: poojaDetailsCtrl
                        //                           .poojaDetailsTab[index]
                        //                           .toString()
                        //                           .toLowerCase(),
                        //                       poojaId: widget.poojaId ?? 0)
                        //                   : null;
                        //             },
                        //             child: Obx(
                        //               () => Container(
                        //                   decoration: BoxDecoration(
                        //                       borderRadius:
                        //                           BorderRadius.circular(8),
                        //                       border: Border.all(
                        //                           color: Colors.black),
                        //                       color: poojaDetailsCtrl
                        //                                   .selectedTabIndex
                        //                                   .value ==
                        //                               index
                        //                           ? Colors.orange.shade200
                        //                           : Colors.white),
                        //                   child: Padding(
                        //                     padding: const EdgeInsets.only(
                        //                         left: 15,
                        //                         right: 15,
                        //                         top: 5,
                        //                         bottom: 5),
                        //                     child: Center(
                        //                         child: Text(
                        //                       poojaDetailsCtrl
                        //                           .poojaDetailsTab[index],
                        //                       style: GoogleFonts.poppins(
                        //                           fontWeight: FontWeight.w600,
                        //                           fontSize: 22),
                        //                     )),
                        //                   )),
                        //             ),
                        //           ),
                        //         );
                        //       },
                        //     ),
                        //   ),
                        // ),

                        SizedBox(
                          height: 50,
                        ),
                        poojaBenefitsWidget(
                            context: context, poojaId: widget.poojaId ?? 0),
                        // poojaDetailsCtrl.selectedTabIndex.value == 9
                        //     ? poojaProcessWidget(
                        //         context: context, poojaId: widget.poojaId ?? 0)
                        //     : poojaDetailsCtrl.selectedTabIndex.value == 0
                        //         ? poojaBenefitsWidget(
                        //             context: context,
                        //             poojaId: widget.poojaId ?? 0)
                        //         // : poojaDetailsCtrl.selectedTabIndex.value == 3
                        //         //     ? poojaPackageWidget(
                        //         //         context: context, poojaId: poojaId ?? 0)
                        //         : poojaDetailsCtrl.selectedTabIndex.value == 0
                        //             ? poojaKeyHighlightWidget(
                        //                 aboutUs: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .aboutUs ??
                        //                     "",
                        //                 date: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .date ??
                        //                     "",
                        //                 offering: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .offering ??
                        //                     '',
                        //                 poojaLocation: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .poojaLocations ??
                        //                     "",
                        //                 special: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .specialTag ??
                        //                     '',
                        //                 socialProof: poojaDashboardCtrl
                        //                         .poojaData[widget.index!]
                        //                         .socialProof ??
                        //                     '',
                        //                 context: context,
                        //                 poojaId: widget.poojaId ?? 0)
                        //             : const SizedBox.shrink()
                      ],
                    ),
                  ),
                ),
              )
            : const ConnectivityWidget(),
      );
    });
  }
}
