
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

String formatDateString(String dateString) {
  try {
    final dateFormat = DateFormat('dd-MM-yyyy HH:mm');
    final parsedDate = dateFormat.parse(dateString);
    final formattedDate =
    DateFormat('dd MMM yyyy, hh:mm a').format(parsedDate);
    return formattedDate;
  } catch (e) {
    return '';
  }
}

Align richTextMaker(
    {required IconData iconName,
      required String titlePrefix,
      required String title,
      required bool isMobile}) {
  return Align(
    alignment: Alignment.centerLeft, // Align the Container to the left
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(width: 1, color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 4),
        child: Row(
          mainAxisSize:
          MainAxisSize.min, // Make Row only as wide as its content
          children: [
            Icon(
              iconName,
              size: isMobile ? 14 : 18,
              color: Colors.grey.withOpacity(0.6),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '${titlePrefix}: ',
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.withOpacity(0.6),
                      ),
                    ),
                    TextSpan(
                      text: title,
                      style: GoogleFonts.poppins(
                        fontSize: isMobile ? 12 : 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}