abstract class MyCustomDateTime{

  static String getCurrentTime(){
    var date = DateTime.now();
    int hour24 = date.hour;
    int hour12 = hour24 % 12 == 0 ? 12 : hour24 % 12;
    String period = hour24 >= 12 ? 'PM' : 'AM';
    int minute = date.minute;
    return '${hour12.toString().padLeft(2, '0')}:$minute $period';
  }

}

