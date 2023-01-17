import 'package:intl/intl.dart';

class Utils {
  static formatDateTime(DateTime dateTime) {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  static isTodayAfterDateTime(DateTime dateTime) {
    return DateTime.now().isAfter(dateTime);
  }
}
