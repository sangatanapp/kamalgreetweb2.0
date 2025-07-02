import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

Future<void> selectStartDateAndTime(BuildContext context) async {
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
      String formattedDate = DateFormat('dd-MM-yyyy').format(pickedDate);
      // postController.startDateString.value = formattedDate;

      String formattedTime = DateFormat('HH:mm').format(selectedDateTime);
      // postController.startTimeString.value = formattedTime;

      String formattedDateTime =
          DateFormat('dd-MM-yyyy HH:mm').format(selectedDateTime);
      // postController.startDate.value.text = formattedDateTime;
    }
  }
}
