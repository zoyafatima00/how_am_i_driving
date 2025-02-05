import 'package:flutter/material.dart';

class AppConstants {
  static String userName = '';
  static String image = '';

  static double getScreenHeight(context) {
    return MediaQuery.of(context).size.height;
  }

  static double getScreenWidth(context) {
    return MediaQuery.of(context).size.width;
  }

  static bool showScreen = false;
}
