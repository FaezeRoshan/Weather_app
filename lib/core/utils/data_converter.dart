
import 'package:intl/intl.dart';

class DateConverter{

static String monthNumberToName(int month) {

  final date = DateTime(2000, month, 1); 
  return DateFormat.MMM().format(date); 
}

  /// change dt to our dateFormat ---5:55 AM/PM--- for Example
  static String changeDtToDateTimeHour(dt, timeZone){
    final formatter = DateFormat.jm();
    return formatter.format(
        DateTime.fromMillisecondsSinceEpoch(
            (dt * 1000) +
                timeZone * 1000,
            isUtc: true));
  }


}