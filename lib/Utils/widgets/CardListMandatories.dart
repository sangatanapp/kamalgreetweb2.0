import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Utils/values/AppConstants.dart';
import 'package:shimmer/shimmer.dart';

Widget shimmerCards() {
  return Shimmer.fromColors(
    baseColor: Colors.grey.withOpacity(0.2),
    highlightColor: Colors.grey.withOpacity(0.1),
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: MediaQuery.of(context).size.width * 0.1,
          height: MediaQuery.of(context).size.height * 0.32,
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              colors: [
                Color(0xFF86F6C7),
                Color(0xFFEEFEFA),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        );
      },
    ),
  );
}

Widget title(String title, final isMobile) {
  return Center(
    child: Text(
      title,
      style: GoogleFonts.poppins(
        fontSize: isMobile ? AppConstants.titleSize : AppConstants.titleSize2,
        fontWeight: FontWeight.w600,
      ),
    ),
  );
}


