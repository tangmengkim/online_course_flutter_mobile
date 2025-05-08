import 'package:intl/intl.dart';

class FormatTimeStamp {
  // Utility function to format the timestamp
  static String formatTimestamp(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      DateTime now = DateTime.now();
      print(dateTime.toString());
      // If the timestamp is from today
      if (dateTime.year == now.year &&
          dateTime.month == now.month &&
          dateTime.day == now.day) {
        // Format: hh:mm AM/PM
        return DateFormat('hh:mm a').format(dateTime);
      } else {
        // Format: dd/MM hh:mm AM/PM
        return DateFormat('MMM dd At hh:mm a').format(dateTime);
      }
    } catch (e) {
      return 'Invalid date'; // Handle errors gracefully if parsing fails
    }
  }

  // If you need to handle different formats, you can add other utility methods.
  static String formatToRelativeTime(String timestamp) {
    try {
      DateTime dateTime = DateTime.parse(timestamp);
      final Duration difference = DateTime.now().difference(dateTime);

      if (difference.inDays > 0) {
        return '${difference.inDays} days ago';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} hours ago';
      } else if (difference.inMinutes > 0) {
        return '${difference.inMinutes} minutes ago';
      } else {
        return 'Just now';
      }
    } catch (e) {
      return 'Invalid date'; // Handle parsing errors gracefully
    }
  }

  static String formatSecondToHour(int seconds) {
    int hours = seconds ~/ 3600; // Get total hours
    int minutes = (seconds % 3600) ~/ 60; // Get remaining minutes
    return "${hours}h ${minutes}mn";
  }

  static String formatSecondToMinute(int seconds) {
    int minutes = seconds ~/ 60; // Get remaining minutes
    int second = (seconds % 60);
    return "${minutes}:${second.toString().padLeft(2, '0')} mins";
  }
}
