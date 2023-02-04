import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Utils {
  static formatDateTime(DateTime dateTime) {
    var formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(dateTime);
  }

  static isTodayAfterDateTime(DateTime dateTime) {
    return DateTime.now().isAfter(dateTime);
  }

  static Map<String, dynamic> convertTimestampToDateTime(
      Map<String, dynamic> json) {
    Timestamp timestamp = json['dateTime'];
    json['dateTime'] = timestamp.toDate();
    return json;
  }
}
