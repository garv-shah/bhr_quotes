import 'package:flutter/material.dart';

class AppThemes {
  /// dark mode theme
  static ThemeData darkTheme = ThemeData(
    backgroundColor: Colors.black,
    primaryColorLight: const Color(0xfffcfcff),
    primaryColor: Colors.black,
    scaffoldBackgroundColor: const Color(0xff12162B),
    canvasColor: const Color(0xff12162B),
    cardColor: const Color(0xff1F2547),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.indigoAccent,
          foregroundColor: Colors.white
      ),
    appBarTheme: const AppBarTheme(
      color: Color(0xff1F2547),
      elevation: 4,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
      ),
    ),
    textTheme: const TextTheme(button: TextStyle(color: Colors.indigoAccent)),
    inputDecorationTheme: InputDecorationTheme(
      disabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white38),
        borderRadius: BorderRadius.circular(8),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white38),
        borderRadius: BorderRadius.circular(8),
      ),
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.indigoAccent),
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    colorScheme: const ColorScheme.dark().copyWith(
        primary: Colors.indigoAccent,
        secondary: Colors.indigo,
        brightness: Brightness.dark),
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.all(Colors.indigoAccent),
        side: const BorderSide(color: Color(0xff585858)),
      )
  );
}
