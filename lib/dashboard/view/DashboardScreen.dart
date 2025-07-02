import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/internet/ConnectivityController.dart';
import 'package:kamal_greet_web_2/commonImagePickers/LogoPickerViewModel.dart';
import 'package:kamal_greet_web_2/dashboard/widget/AppCardsWidget.dart';

final connectivityCtrl = Get.put(ConnectivityController());
final LogoPickerViewModel logoPickerCtrl = Get.put(LogoPickerViewModel());

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: [
          TextButton(
              onPressed: () => context.push("/payment"),
              child: Text(
                "Payment",
                style: GoogleFonts.poppins(fontWeight: FontWeight.w500,color: Colors.black),
              ))
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appCardsWidget(
                    onTap: () {},
                    title: "Post Karo",
                    imageString: "assets/images/postKaroLogo.png"),
                appCardsWidget(
                    onTap: () {
                      context.go("/guruvani/dashboard");
                    },
                    title: "Guru Vani",
                    imageString: "assets/images/guruvanilogo.png"),
                appCardsWidget(
                    onTap: () {},
                    title: "Sanatan",
                    imageString: "assets/images/sanatanlogo.png"),
                appCardsWidget(
                    onTap: () {},
                    title: "Islamic",
                    imageString: "assets/images/islamiclogo.png"),
                appCardsWidget(
                    onTap: () {},
                    title: "Islamic International",
                    imageString: "assets/images/islamicdaily.jpg")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
