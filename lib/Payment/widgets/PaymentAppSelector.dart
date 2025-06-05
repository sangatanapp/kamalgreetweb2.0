import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Payment/view/PaymentScreen.dart';

Widget paymentAppSelector() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 20),
      buildAppOption('PostShare', 'postshare'),
      const SizedBox(width: 20),
      buildAppOption('PostKaro', 'postkaro'),
      const SizedBox(width: 20),
      buildAppOption('Guruvani', 'guruvani'),
      const SizedBox(width: 20),
      buildAppOption('Islamic', 'islamic'),
      const SizedBox(width: 20),
      buildAppOption('SharePost', 'sharepost'),
      const SizedBox(width: 20),
      buildAppOption('PoliticalPoster', 'politicalposter')
    ],
  );
}

Widget buildAppOption(String label, String value) {
  return Obx(
    () => InkWell(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey),
          color: paymentCtrl.whichAppSelected.value == value
              ? Colors.yellow.withOpacity(0.5)
              : Colors.transparent, // Highlight selected option
        ),
        child: Row(
          children: [
            Radio<String>(
              value: value,
              groupValue: paymentCtrl.whichAppSelected.value,
              onChanged: (newValue) {
                paymentCtrl.whichAppSelected.value = newValue!;
                paymentCtrl.whichAppSelected.value = newValue.toLowerCase();
                paymentCtrl.whichAppSelected.refresh();
              },
              activeColor: Colors.green.shade800,
            ),
            const SizedBox(width: 8), // Add spacing between radio and text
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 16,
                color: paymentCtrl.whichAppSelected.value == value
                    ? Colors.black
                    : Colors.grey.withOpacity(0.6),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
