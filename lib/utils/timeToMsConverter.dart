import 'package:flutter/material.dart';

class TimeToMsConverter {
  int converter(TimeOfDay timeOfDay) {
    // Specify the desired time of day

    // Get the current date
    DateTime now = DateTime.now();

    // Create a DateTime object with the current date and specified time of day
    DateTime dateTime = DateTime(
      now.year,
      now.month,
      now.day,
      timeOfDay.hour,
      timeOfDay.minute,
    );

    // Calculate the number of milliseconds since midnight
    return dateTime.microsecondsSinceEpoch;
  }
}
