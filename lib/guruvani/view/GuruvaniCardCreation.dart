import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicAppbar.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/Utils/widgets/EndDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/PaddingGenerator.dart';
import 'package:kamal_greet_web_2/Utils/widgets/StartDateSelector.dart';
import 'package:kamal_greet_web_2/Utils/widgets/SubtitleGenerator.dart';
import 'package:kamal_greet_web_2/guruvani/widgets/GuruSelector.dart';
import 'package:kamal_greet_web_2/guruvani/widgets/GuruvaniNotificationBox.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import '../widgets/GuruvaniCreationButtons.dart';
import '../widgets/GuruvaniDateTimeWidget.dart';
import 'GuruvaniDashboard.dart';

class GuruvaniCardCreation extends StatelessWidget {
  const GuruvaniCardCreation({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      return Obx(
        () {
          if (connectivityController.connectionType ==
                  MConnectivityResult.wifi ||
              connectivityController.connectionType ==
                  MConnectivityResult.mobile) {
            return Scaffold(
                appBar: AppBar(
                  elevation: 1,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  actions: const [DynamicAppbar()],
                ),
                backgroundColor: AppColors.creationScreenBackground,
                body: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.16),
                  child: formWidget(context),
                ));
          } else {
            return const ConnectivityWidget();
          }
        },
      );
    });
  }

  Widget formWidget(BuildContext context) {
    return Obx(
      () => Container(
        decoration: BoxDecoration(
          color: AppColors.creationScreenBackground,
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// START DATE & END DATE
                guruvaniDateTimeWidget(context: context),

                formPadding(),

                /// POST TITLE
                creationSubTitle(
                    "title".tr,
                    DynamicTextfield(
                      onChange: (value) {
                        guruvaniCtrl.titleController.refresh();
                      },
                      maxLength: 50,
                      controller: guruvaniCtrl.titleController.value,
                      height: 55,
                      fillColor: AppColors.whiteCard,
                      hintText: "title".tr,
                    )),
                formPadding(),

                /// SHARING CONTENT
                creationSubTitle(
                    "postContent".tr,
                    DynamicTextfield(
                      maxLength: 150,
                      // height: 100,
                      maxLines: 3,
                      controller: guruvaniCtrl.sharingContent.value,
                      fillColor: AppColors.whiteCard,
                      hintText: "sharingContent".tr,
                    )),
                formPadding(),
                creationSubTitle("Select Guru", guruSelector(context)),

                formPadding(),

                // /// IMAGE SETTINGS BOX
                // postImageBox(
                //     context: context, isPhoto: guruvaniCtrl.getPostType()),
                //
                /// NOTIFICATION BOX
                guruvaniNotificationBox(),

                /// CANCEL & SUBMIT BUTTON
                guruvaniCreationButtons(context: context),

                formPaddingPlus(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
