import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicButton.dart';
import 'package:kamal_greet_web_2/Utils/widgets/DynamicTextfield.dart';
import 'package:kamal_greet_web_2/login/viewmodel/LoginViewModel.dart';
import '../../../Utils/internet/ConnectivityController.dart';
import '../../../Utils/values/AppConstants.dart';
import '../../Utils/internet/ConnectivityWidget.dart';

final loginController = Get.put(LoginViewModel());
final connectivityController = Get.put(ConnectivityController());

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
      final isMobile = constraints.maxWidth < 800;
      final formWidth = isMobile ? null : constraints.maxWidth * 0.45;

      return Scaffold(
          body: Obx(
        () => connectivityController.connectionType == MConnectivityResult.wifi ||
            connectivityController.connectionType == MConnectivityResult.mobile
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
                                  flex: 4,
                                  child: SizedBox(
                                    width: Get.width,
                                    child: Image.asset(
                                        'assets/images/BackgroundImageMobile.png',
                                        fit: BoxFit.fill),
                                  )),
                              Expanded(flex: 6, child: loginField(context)),
                            ],
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height * 0.7,
                            child: Card(
                              elevation: 100,
                              margin: const EdgeInsets.all(15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: Opacity(
                                        opacity: 0.55,
                                        child: ClipRRect(
                                          borderRadius: const BorderRadius.only(
                                              bottomLeft: Radius.circular(20),
                                              topLeft: Radius.circular(20)),
                                          child: Image.asset(
                                              'assets/images/BackgroundImage.png',
                                              fit: BoxFit.fill),
                                        )),
                                  )),
                                  Expanded(
                                    child: loginField(context),
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                ),
              )
            : const ConnectivityWidget(),
      ));
    });
  }

  ListView loginField(BuildContext context) {
    return ListView(
      children: [
        const SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            'welcome'.tr,
            style: GoogleFonts.poppins(
                fontSize: AppConstants.titleSize1, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Center(
          child: Text(
            'login'.tr,
            style: GoogleFonts.poppins(
                color: Colors.grey,
                fontSize: AppConstants.titleSize,
                fontWeight: FontWeight.w400),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Center(
            child: Text(
          'enterNumber'.tr,
          style: GoogleFonts.poppins(
              fontSize: AppConstants.titleSize, fontWeight: FontWeight.w600),
        )),
        const SizedBox(
          height: 40,
        ),
        Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: DynamicTextfield(
                  counterText: ' ',
                  onSubmit: (value) {
                    if (formKey.currentState!.validate()) {
                      if (context.mounted) {
                        loginController
                            .loginUser(
                                mobileNumber:
                                    loginController.phoneNumber.value.text)
                            .then((value) => context.go('/verifyOtp'));
                      }
                    }
                  },
                  maxLength: 10,
                  maxLines: 1,
                  controller: loginController.phoneNumber.value,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^[5-9][0-9]{0,9}$')),
                  ],
                  keyboardType: TextInputType.phone,
                  validator: ((value) {
                    if (value!.isEmpty) {
                      return 'validNumber'.tr;
                    } else if (value.length != 10) {
                      return 'validNumber'.tr;
                    } else if (RegExp(r'0000000000').hasMatch(value)) {
                      return 'validNumber'.tr;
                    } else if (value[0] == "1" ||
                        value[0] == "2" ||
                        value[0] == "3" ||
                        value[0] == "4") {
                      return 'validNumber'.tr;
                    }
                    return null;
                  }),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  hintText: 'enterNumber'.tr,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      left: 8,
                      right: 5,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'prefixMobile'.tr,
                          style: const TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  height: 42,
                  width: 240,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () {
                  if (loginController.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    return DynamicButton(
                      textSize: 18,
                      backgroundColor: Colors.yellow.shade800,
                      textColor: Colors.black,
                      boldness: FontWeight.w400,
                      text: 'continue'.tr,
                      width: 200,
                      height: 37,
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          if (context.mounted) {
                            {
                              loginController
                                  .loginUser(
                                      mobileNumber: loginController
                                          .phoneNumber.value.text)
                                  .then((value) => context.go('/verifyOtp'));
                            }
                          }
                        }
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
