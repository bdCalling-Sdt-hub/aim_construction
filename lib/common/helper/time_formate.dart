 import 'package:intl/intl.dart';

class TimeFormatHelper {
  static String formatDate(DateTime date) {
    return DateFormat('dd MMM, yyyy').format(date);
  }
  static String formatDateWithDay(DateTime date) {
    return DateFormat('EEEE, dd MMM, yyyy').format(date);
  }

  static String year(DateTime date) {
    return DateFormat('yyyy').format(date);
  }

  static String month(DateTime date) {
    return DateFormat('MM').format(date);
  }

  static String dateMountFormat(DateTime date) {
    return DateFormat('dd\n MMM ').format(date);
  }

  static String timeFormat(DateTime date) {
    return DateFormat('hh:mm a').format(date);
  }

  static timeWithAMPM(String time) {
    DateTime parsedTime = DateFormat('HH:mm:ss').parse(time);
    String formattedTime = DateFormat('h:mm a').format(parsedTime);
    return formattedTime;
  }

 /* static Future<void> isFutureDate(String input) async {
    try {
      DateTime date = DateTime.parse(input);
      DateTime now = DateTime.now();
      await PrefsHelper.setBool(AppConstants.isFutureDate, date.isAfter(now));
    } catch (e) {
      PrefsHelper.setBool(AppConstants.isFutureDate, false);
    }
  }*/


  static int convertTo24Hour(String time) {
    final parts = time.split(' ');
    if (parts.length != 2) throw ArgumentError('Invalid time format');

    final timePart = parts[0];
    final period = parts[1].toUpperCase();

    final timeSegments = timePart.split(':');
    if (timeSegments.length != 2) throw ArgumentError('Invalid time format');

    int hour = int.parse(timeSegments[0]);
    final int minute = int.parse(timeSegments[1]);

    if (period == 'PM' && hour != 12) {
      hour += 12; // Convert PM to 24-hour time
    } else if (period == 'AM' && hour == 12) {
      hour = 0; // Convert midnight (12 AM) to 0
    }
    return hour;
  }

  static String convertTo12Hour(int hour, int minute) {
    // Validate the input hour and minute
    if (hour < 0 || hour > 23) {
      throw ArgumentError('Hour must be between 0 and 23.');
    }
    if (minute < 0 || minute > 59) {
      throw ArgumentError('Minute must be between 0 and 59.');
    }

    // Determine AM or PM
    final String period = hour >= 12 ? 'PM' : 'AM';

    // Convert hour to 12-hour format
    final int twelveHour = hour % 12 == 0 ? 12 : hour % 12;

    // Format the time as a string
    return '${twelveHour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')} $period';
  }
}