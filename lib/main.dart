import 'package:flutter/material.dart';
import 'package:todo_demo/home/homescreen.dart';
import 'package:todo_demo/my_theme/my_theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.light,
      initialRoute: Homescreen.routeName,
      routes: {
        Homescreen.routeName: (context) => Homescreen(),

      },
    );
  }
}

