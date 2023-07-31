import 'package:intl/intl.dart';
class Util{

  static String getFormatedString(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }

  static DateTime convertToUtc(DateTime localDateTime) {
    Duration timeZoneOffset = Duration(hours: 5, minutes: 30);
    DateTime adjustedUtcDateTime = localDateTime.subtract(timeZoneOffset);
    return adjustedUtcDateTime;
  }
}