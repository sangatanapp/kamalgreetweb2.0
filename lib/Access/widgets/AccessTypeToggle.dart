import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamal_greet_web_2/Access/view/AccessScreen.dart';

Widget accessTypeToggle() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.start,
    children: [
      const SizedBox(width: 7),
      buildAppOption('ResetAccess', 'resetaccess'),
      const SizedBox(width: 7),
      buildAppOption('GiveSubscription', 'givesubscription'),
      const SizedBox(width: 7),
      buildAppOption('GetDisputeData', 'getdisputedata')
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
              groupValue: accessCtrl.whichTypeToggle.value,
              onChanged: (newValue) {
                accessCtrl.whichTypeToggle.value = newValue!;
                accessCtrl.whichTypeToggle.value = newValue.toLowerCase();
                accessCtrl.whichTypeToggle.refresh();
                accessCtrl.showDispute.value = false;
                accessCtrl.showDispute.refresh();
              },
              activeColor: Colors.green.shade800,
            ),
            const SizedBox(width: 3),
            Text(
              label,
              style: GoogleFonts.poppins(
                fontSize: 12,
                color: accessCtrl.whichTypeToggle.value == value
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
