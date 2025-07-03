import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectEndDateAndTime(
    {required BuildContext context,
    required TextEditingController endDateController}) async {
  DateTime? pickedDate = await showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2000),
    lastDate: DateTime(2101),
  );

  if (pickedDate != null) {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      DateTime selectedDateTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      endDateController.text =
          DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
    }
  }
}
