import 'package:intl/intl.dart';

class HomescreenController {
  // Function to format the time
  String formatTime(DateTime time) {
    DateTime now = DateTime.now();
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      // If the date is today, return hour:minute in AM/PM format
      return DateFormat('h:mm a').format(time); // Example: "2:30 PM"
    } else {
      // If the date is not today, return the day of the week
      return DateFormat('EEEE').format(time); // Returns "Monday", "Tuesday", etc.
    }
  }
}