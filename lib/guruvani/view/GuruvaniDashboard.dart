import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/status.dart';
import 'package:kamal_greet_web_2/guruvani/viewmodel/GuruvaniViewModel.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';

import '../../Utils/widgets/CardListMandatories.dart';

final GuruvaniViewModel guruvaniCtrl = Get.put(GuruvaniViewModel());

class GuruvaniDashboard extends StatelessWidget {
  const GuruvaniDashboard({super.key});

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
                                    radius: 100,
                                    backgroundColor: AppColors.primaryColor,
                                    width: isMobile ? 80 : 150,
                                    text: 'addPost'.tr,
                                    boldness: FontWeight.w500,
                                    height: isMobile ? 26 : 46,
                                    textSize: isMobile ? 8 : 16,
                                    onTap: () {},
                                  ),
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
                              /// LIST OF POSTS
                              Obx(() {
                                switch (guruvaniCtrl.rxRequestStatus.value) {
                                  case Status.INITIAL:
                                    return const SizedBox.shrink();
                                  case Status.COMPLETED:
                                  // return Flexible(
                                  //   child: programListBuilder(isMobile),
                                  // );
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
              )
            : const ConnectivityWidget(),
      );
    });
  }
}
