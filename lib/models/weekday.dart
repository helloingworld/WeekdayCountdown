import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

enum Weekday { monday, tuesday, wednesday, thursday, friday, saturday, sunday }

class Weekdays {
  /// Returns the ARGB color value for the specified day.
  static Color colorOf(Weekday day) => _weekdayColors[day];

  /// Returns the name of the specified day (e.g. "Monday").
  static String nameOf(Weekday day) {
    final String name = describeEnum(day);
    return '${name.substring(0, 1).toUpperCase()}${name.substring(1).toLowerCase()}';
  }

  /// A map with the corresponding ARGB color value for each counter type.
  static const Map<Weekday, Color> _weekdayColors = {
    Weekday.monday: Colors.yellow,
    Weekday.tuesday: Colors.pink,
    Weekday.wednesday: Colors.green,
    Weekday.thursday: Colors.orange,
    Weekday.friday: Colors.blue,
    Weekday.saturday: Colors.purple,
    Weekday.sunday: Colors.red,
  };

  static Duration countdownTo(int selectedWeekday) {
    DateTime now = DateTime.now();
    int currentWeekday = now.weekday;

    int dayDiff = 0;

    if (selectedWeekday > currentWeekday) {
      dayDiff = selectedWeekday - currentWeekday;
    } else if (selectedWeekday < currentWeekday) {
      dayDiff = selectedWeekday + 7 - currentWeekday;
    } else {
      return null;
    }

    DateTime day = now.add(Duration(days: dayDiff));
    day = DateTime(day.year, day.month, day.day);

    return day.difference(now);
  }
}
