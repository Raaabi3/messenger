import 'package:intl/intl.dart';

class HomescreenController {
  String formatTime(DateTime time) {
    DateTime now = DateTime.now();
    if (now.day == time.day && now.month == time.month && now.year == time.year) {
      return DateFormat('h:mm a').format(time); 
    } else {
      return DateFormat('EEE').format(time); 
    }
  }
}