import 'package:intl/intl.dart';

class Utils {
  static String toDateTime(DateTime dateTime) {
    final date = DateFormat.yMMMEd('nl').format(dateTime);
    final time = DateFormat.Hm('nl').format(dateTime);
    return '$date $time';
  }

  static String toDate(DateTime dateTime) {
    final date = DateFormat.yMMMEd('nl').format(dateTime);
    return date;
  }

  static String toTime(DateTime dateTime) {
    final time = DateFormat.Hm('nl').format(dateTime);
    return time;
  }
}
