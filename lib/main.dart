import 'package:flutter/material.dart';
import 'package:nasa_apod/MyHomePage.dart';
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
/*      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),*/
      theme: ThemeClass.lightTheme,
      darkTheme: ThemeClass.darkTheme,

   /*   theme: ThemeData(useMaterial3: true, colorScheme: lightColorScheme),
      darkTheme: ThemeData(useMaterial3: true, colorScheme: darkColorScheme),
*/      themeMode: ThemeMode.system,
      home: MyHomePage(),
    );
  }
}

