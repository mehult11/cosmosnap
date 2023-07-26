import 'package:flutter/material.dart';
import 'package:nasa_apod/UI/MyHomePage.dart';
import 'package:nasa_apod/Theme/ThemeData.dart';
void main() async{

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,
      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

