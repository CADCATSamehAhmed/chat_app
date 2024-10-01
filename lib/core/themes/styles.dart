import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class Fonts{
  static TextStyle font30 = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.bold
  );
  static TextStyle font25 = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 25,
    fontWeight: FontWeight.w500
  );
  static TextStyle font21 = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 21,
  );
  static TextStyle font18 = GoogleFonts.inter(
    color: Colors.black,
    fontSize: 18,
  );
}