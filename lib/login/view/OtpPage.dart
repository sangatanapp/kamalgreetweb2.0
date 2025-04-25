import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityWidget.dart';
import 'package:kamal_greet_web_2/Utils/values/AppColors.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/login/view/LoginPage.dart';
import 'package:pinput/pinput.dart';
import '../../../Utils/internet/ConnectivityController.dart';
import '../../../Utils/values/AppConstants.dart';

class OtpPage extends StatelessWidget {
  OtpPage({super.key});

  final activePinTheme = PinTheme(
      width: 42,
      height: 42,
      textStyle: GoogleFonts.poppins(fontSize: 22, color: Colors.black),
      decoration: BoxDecoration(
          color: AppColors.yellowBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: AppColors.primaryColor,
            width: 2,
          )));
  final defaultPinTheme = PinTheme(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        color: Colors.yellow.shade100,
        borderRadius: BorderRadius.circular(12),
      ));

  @override
  Widget build(BuildContext context) {
    loginController.otp.value.text = "909192";


    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final isMobile = constraints.maxWidth < 800;
        final formWidth = isMobile ? null : constraints.maxWidth * 0.45;

        return Obx(
          () => Scaffold(
              body: connectivityController.connectionType ==
                          MConnectivityResult.wifi ||
                      connectivityController.connectionType ==
                          MConnectivityResult.mobile
                  ? Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                        color: isMobile ? Colors.white : null,
                        gradient: isMobile
                            ? null
                            : LinearGradient(
                                colors: [
                                  Colors.yellow.shade50,
                                  Colors.orange.shade100,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: FractionallySizedBox(
                          widthFactor: formWidth != null ? 0.58 : 1.0,
                          child: isMobile
                              ? Column(
                                  children: [
                                    Expanded(
                                        flex: 3,
                                        child: Container(
                                          width: Get.width,
                                          child: Image.asset(
                                              'assets/images/BackgroundImageMobile.png',
                                              fit: BoxFit.fill),
                                        )),
                                    Expanded(
                                        flex: 5,
                                        child: otpField(context, isMobile)),
                                  ],
                                )
                              : SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Card(
                                    elevation: 100,
                                    margin: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Container(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          child: Opacity(
                                              opacity: 0.55,
                                              child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.only(
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(
                                                                20)),
                                                child: Image.asset(
                                                    'assets/images/BackgroundImage.png',
                                                    fit: BoxFit.fill),
                                              )),
                                        )),
                                        Expanded(
                                          child: otpField(context, isMobile),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                        ),
                      ),
                    )
                  : const ConnectivityWidget()),
        );
      },
    );
  }

  Widget title(String title) {
    return Center(
      child: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: AppConstants.titleSize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget subtitle(String subtitle) {
    return Text(
      subtitle,
      textAlign: TextAlign.center,
      style: GoogleFonts.poppins(
        fontSize: AppConstants.subTitleSize,
        fontWeight: FontWeight.w400,
      ),
    );
  }

  ListView otpField(BuildContext context, final isMobile) {
    return ListView(
      children: [
        const SizedBox(
          height: 20,
        ),
        Center(
          child: Text(
            'enterOtp'.tr,
            style: GoogleFonts.poppins(
                fontSize: AppConstants.titleSize1, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Center(
          child: Text(
            "हमने आपके ${loginController.phoneNumber.value.text} पर ओटीपी भेज दी है",
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: AppConstants.titleSize,
                fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Padding(
          padding: isMobile
              ? const EdgeInsets.only(left: 200, right: 200)
              : const EdgeInsets.only(left: 100, right: 100),
          child: SizedBox(
            height: 100,
            width: 50,
            child: Image.asset('assets/images/OtpIcon.png',
                width: 50, height: 100, fit: BoxFit.fill),
          ),
        ),
        const SizedBox(height: 30),
        Padding(
          padding: const EdgeInsets.only(left: 4, right: 4),
          child: Pinput(
            controller: loginController.otp.value,
            length: 6,
            defaultPinTheme: defaultPinTheme.copyWith(
              decoration: defaultPinTheme.decoration!.copyWith(),
            ),
            focusedPinTheme: activePinTheme.copyWith(
              decoration: activePinTheme.decoration!.copyWith(
                border: Border.all(
                  width: 1,
                  color: Colors.yellow.shade800,
                ),
              ),
            ),
            onCompleted: (pin) => debugPrint(pin),
          ),
        ),
        const SizedBox(height: 20),
        Obx(
          () {
            if (loginController.isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Column(
                children: [
                  loginController.isError != false
                      ? Text(
                          'invalidOtp'.tr,
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        )
                      : const SizedBox.shrink(),
                  const SizedBox(
                    height: 20,
                  ),
                  DynamicButton(
                    textSize: 18,
                    backgroundColor: Colors.yellow.shade800,
                    textColor: Colors.black,
                    boldness: FontWeight.w400,
                    text: 'verifyOtp'.tr,
                    width: 200,
                    height: 37,
                    onTap: () {
                      if (loginController.otp.value.text.isNotEmpty &&
                          loginController.otp.value.text.length >= 4) {
                        if (context.mounted) {
                          loginController.submitOTP(context: context);
                        }
                      } else {
                        Get.showSnackbar(
                          const GetSnackBar(
                            title: 'Please enter Otp',
                            message: 'User Registered Successfully',
                            duration: Duration(seconds: 3),
                          ),
                        );
                      }
                    },
                  ),
                ],
              );
            }
          },
        ),
        const SizedBox(height: 35),
      ],
    );
  }
}
