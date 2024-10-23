import 'package:flutter/material.dart';

abstract class MyCustomColor{

  static Color? getStatusBgColor(int? colorNumber){
    if(colorNumber != null){
      return colors[colorNumber];
    }
    return null;
  }

  static List<Color> colors = [
    Colors.grey,
    Colors.green,
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.brown,
    Colors.purple,
    Colors.orange,
  ];


}
