import 'package:intl/intl.dart';
class Util{

  static String getFormatedString(DateTime dateTime){
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    return formatter.format(dateTime);
  }
}