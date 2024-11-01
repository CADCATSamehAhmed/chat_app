import 'package:flutter/material.dart';

abstract class MyCustomColor{

  static Color? getStatusBgColor(int? colorNumber){
    if(colorNumber != null){
      return colors[colorNumber];
    }
    return null;
  }

  static List<Color> colors = [
    Colors.blue,
    Colors.red,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
    Colors.brown,
    Colors.grey,
    Colors.green,
  ];
}
