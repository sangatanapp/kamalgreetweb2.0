import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget appCardsWidget({required String imageString, required String title}) {
  return Card(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20), // Adjust radius as needed
    ),
    elevation: 3,
    child: Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset(imageString, height: 200, width: 220),
          SizedBox(height: 15),
          Text(title,
              style:
                  GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.w600)),
          SizedBox(height: 15),
        ],
      ),
    ),
  );
}
