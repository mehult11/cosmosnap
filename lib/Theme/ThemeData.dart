import 'package:flutter/material.dart';

class ThemeClass{
  static ThemeData lightTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          backgroundColor: Colors.indigo.shade200!,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.indigo.shade900),
          titleTextStyle: TextStyle(color: Colors.indigo.shade900,fontSize: 25)
      ),
      colorScheme: ColorScheme.light(
        primary: Colors.indigo.shade900,
        secondary: Colors.indigo.shade200,
        background: Colors.indigo.shade50,
      ),
      textTheme: TextTheme(
          labelLarge: TextStyle(color: Colors.indigo.shade900),
          bodySmall: TextStyle(color: Colors.indigo[500])
      )
  );


  static ThemeData darkTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF1C1B1F),
          elevation: 0,
          iconTheme: IconThemeData(color: Color(0xFFE6E1E5)),
          titleTextStyle: TextStyle(color: Color(0xFFE6E1E5),fontSize: 25)
      ),
      colorScheme: ColorScheme.dark(
        //   background: Colors.black,
        primary: Colors.grey[900]!,
        secondary: Color(0xFF000000),
        background: Color(0xFF1C1B1F)!
      ),
      textTheme: TextTheme(
          bodySmall: TextStyle(color: Colors.grey)
      )
  );
}
ThemeClass _themeClass = ThemeClass();