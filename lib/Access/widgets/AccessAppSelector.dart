import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Access/view/AccessScreen.dart';

Widget accessAppSelector() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 7),
      buildAppOption('PostShare', 'postshare'),
      const SizedBox(width: 7),
      buildAppOption('PostKaro', 'postkaro'),
      const SizedBox(width: 7),
      buildAppOption('Guruvani', 'guruvani'),
      const SizedBox(width: 7),
      buildAppOption('Islamic', 'islamic'),
      const SizedBox(width: 7),
      buildAppOption('SharePost', 'sharepost'),
      const SizedBox(width: 7),
      buildAppOption('PoliticalPoster', 'political'),
      const SizedBox(width: 7),
      buildAppOption('JaiBhim', 'jaibhim')
    ],
  );
}

Widget buildAppOption(String label, String value) {
  return Obx(
    () => InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
          color: accessCtrl.whichAppSelected.value == value
              ? Colors.yellow.withOpacity(0.5)
              : Colors.transparent, // Highlight selected option
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: accessCtrl.whichAppSelected.value,
              onChanged: (newValue) {
                accessCtrl.whichAppSelected.value = newValue!;
                accessCtrl.whichAppSelected.value = newValue.toLowerCase();
                accessCtrl.whichAppSelected.refresh();
              },
              activeColor: Colors.green.shade800,
            ),
            const SizedBox(width: 3), // Add spacing between radio and text
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: accessCtrl.whichAppSelected.value == value
                    ? Colors.black
                    : Colors.grey.withOpacity(0.8),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
