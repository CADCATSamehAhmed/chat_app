import 'package:intl/intl.dart';

abstract class MyCustomDateTime {
  static DateTime today = DateTime.now();

  // static String getCurrentTime(){
  //   var date = DateTime.now();
  //   int hour24 = date.hour;
  //   int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
  //   String period = hour24 >= 12 ? 'PM' : 'AM';
  //   int minute = date.minute;
  //   return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  // }

  static String getDayName(DateTime dateTime) {
    String day = DateFormat('EEE').format(dateTime);
    return day;
  }

  static String getTime(DateTime dateTime) {
    String time = DateFormat('h:mm a').format(dateTime);
    return time;
  }

  static String getTimeSmart(DateTime dateTime) {
    String dayTime = DateFormat('h:mm a').format(dateTime);
    if (dateTime.month == today.month && (today.day - dateTime.day == 1)) {
      dayTime = 'yesterday';
    } else if (dateTime.month == today.month &&
        (today.day - dateTime.day > 1)) {
      dayTime = DateFormat('d/M/y').format(dateTime);
    }
    return dayTime;
  }

  static String getSmartTime(DateTime dateTime) {
    String dayTime = DateFormat('h:mm a').format(dateTime);
    if (today.day - dateTime.day == 1) {
      dayTime = '$dayTime,yesterday';
    }else if (today.hour == dateTime.hour && today.minute == dateTime.minute) {
      dayTime = 'Now';
    } else if (today.hour == dateTime.hour) {
      String minuteString = (today.minute - dateTime.minute > 1) ? 'minutes' : 'minute';
      dayTime = 'Before ${today.minute - dateTime.minute} $minuteString';
    } else if (today.day - dateTime.day == 0) {
      dayTime = '$dayTime,today';
    }
    return dayTime;
  }

  static bool checkIfStatusExpired(DateTime dateTime) {
    if(dateTime.month == today.month && (today.day-dateTime.day==0 || today.day-dateTime.day==1)) {
      return true;
    } else if(today.month-today.month==1 && today.day-dateTime.day>1) {
      return true;
    } else{
      return false;
    }
  }

// static String formatDateAndTime(DateTime dateTime) {
//   String day = DateFormat('EEE, d/M/y').format(dateTime);
//   String time = DateFormat('h:mm a').format(dateTime);
//   return '$day at $time';
// }
}
