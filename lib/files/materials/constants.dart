import 'package:flutter/material.dart';

class Col {
  final bool isDark;
  Col({required this.isDark}) {
    boxColor = isDark ? const Color(0xFF2E3239) : const Color(0xFFE7ECEF);
    avaterBackground = isDark
        ? const Color.fromARGB(255, 19, 46, 58)
        : const Color.fromARGB(225, 29, 180, 197);
    iconsColor = isDark
        ? const Color.fromARGB(255, 156, 157, 159)
        : const Color(0xFF696969);
    textColor = isDark
        ? const Color(0xFF837F7A)
        : const Color.fromARGB(255, 255, 255, 255);
    inputFillColor = isDark ? const Color(0xFF1F3038) : const Color(0xFF8AB7CC);
    listTileFillCol = isDark
        ? const Color.fromARGB(255, 39, 43, 49)
        : const Color.fromARGB(255, 194, 211, 220);
  }

  Color? boxColor;
  Color? avaterBackground;
  Color? iconsColor;
  Color? textColor;
  Color? inputFillColor;
  Color? listTileFillCol;
}
