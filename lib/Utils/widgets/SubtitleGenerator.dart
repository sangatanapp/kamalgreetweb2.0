import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';

Widget creationSubTitle(String title, Widget child) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      const SizedBox(
        height: 10,
      ),
      Padding(
        padding: const EdgeInsets.only(left: 10),
        child: child,
      )
    ],
  );
}
