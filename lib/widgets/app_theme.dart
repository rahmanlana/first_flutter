import 'package:flutter/material.dart';
class AppTheme {
  static const Color primaryColor = Color.fromARGB(255, 230, 4, 4);

 static ThemeData get light{
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
         brightness: Brightness.light,
         secondary: Colors.black,
      ),
      fontFamily: 'SF Pro Display',
    );
  }
  static ThemeData get dark{
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
         brightness: Brightness.dark,
         secondary: Colors.white,
      ),
      fontFamily: 'SF Pro Display',
    );
  }
}