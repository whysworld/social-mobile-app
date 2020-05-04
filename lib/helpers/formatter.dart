import 'package:flutter/material.dart';

class Formatter {
  static String twoDigits(int n) {
    if (n >= 10) return "$n";
    return "0$n";
  }

  static int totalMinutes(TimeOfDay t) {
    if (t == null) return 0;
    return t.hour * 60 + t.minute;
  }

  static String doubleMinutesToHMMFormat(double minutes) {
    int totalMinutes = minutes.toInt();
    return minutesToHMMFormat(totalMinutes);
  }

  static String minutesToHMMFormat(int totalMinutes) {
    int hours = (totalMinutes / 60).floor();
    int minutes = totalMinutes % 60;
    return "$hours h ${twoDigits(minutes)} min";
  }

  static String minutesToHMMFormatWithoutSpace(int totalMinutes) {
    int hours = (totalMinutes / 60).floor();
    int minutes = totalMinutes % 60;
    return "${hours}h ${twoDigits(minutes)}min";
  }

  static String timeOfDayToString(TimeOfDay t) {
    if (t == null) return null;
    return "${t.hour}:${twoDigits(t.minute)}";
  }

  static TimeOfDay minutesToTimeOfDay(double doubleMinutes) {
    if (doubleMinutes == null) return null;
    int totalMinutes = doubleMinutes.toInt();
    int hours = (totalMinutes / 60).floor();
    int minutes = totalMinutes % 60;
    return TimeOfDay(hour: hours, minute: minutes);
  }

  static String upperFirstLetter(String string) {
    if (string == null)
      return string;
    else if (string.length == 1)
      return string.toUpperCase();
    else
      return '${string[0].toUpperCase()}${string.substring(1)}';
  }

  static String listString(List<String> toList, int size) {
    String finalList = '';
    int counter = 0;
    toList.forEach((f) {
      if (finalList.length < size) {
        finalList += "$f, ";
      } else {
        counter++;
      }
    });

    if (counter == 0) return finalList;

    return '$finalList and $counter more.';
  }
}
