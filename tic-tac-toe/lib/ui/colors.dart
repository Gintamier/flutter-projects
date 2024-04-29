import 'dart:ui';

import 'package:flutter/material.dart';

class MainColor {
  static Color x = Color(0xFFe32636);
  static Color o = Color(0xFF0000bb);
  static Color background = Color(0xFFa7a5a6);
  static Gradient backgroundGradient = LinearGradient(
    begin: Alignment.topRight,
    end: Alignment.centerLeft,
    colors: [
      Colors.grey,
      Colors.grey.shade700,
    ],
  );
  static Color primaryButton = Color(0xFFf25601);
  static Color white = Color(0xFFFFFFFF);
}// TODO Implement this library.