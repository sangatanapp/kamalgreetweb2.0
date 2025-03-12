import 'package:flutter/material.dart';
import 'package:kamal_greet_web_2/dashboard/widget/AppCardsWidget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                appCardsWidget(
                    title: "Post Karo",
                    imageString: "assets/images/postKaroLogo.png"),
                appCardsWidget(
                    title: "Guru Vani",
                    imageString: "assets/images/guruvanilogo.png"),
                appCardsWidget(
                    title: "Sanatan",
                    imageString: "assets/images/sanatanlogo.png"),
                appCardsWidget(
                    title: "Islamic",
                    imageString: "assets/images/islamiclogo.png"),
                appCardsWidget(
                    title: "Islamic International",
                    imageString: "assets/images/islamiclogo.png")
              ],
            ),
          ],
        ),
      ),
    );
  }
}
