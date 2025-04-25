import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

Widget noLogoWidget(String text) {
  return SizedBox(
      width: 100,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(width: 0.5, color: Colors.grey)),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.add_a_photo,
                color: Colors.black,
                size: 30,
              ),
              const SizedBox(height: 5),
              Text(
                text,
                style: GoogleFonts.poppins(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ));
}
