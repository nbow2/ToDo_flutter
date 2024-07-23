import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_demo/home/homescreen.dart';
import 'package:todo_demo/my_theme/my_theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_demo/provider/config_provider.dart';


void main() {
  runApp(
      MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ConfigProvider()),
      ]  ,
      child:  MyApp()
  )
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ConfigProvider>(context);
    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.light,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: Homescreen.routeName,
      routes: {
        Homescreen.routeName: (context) => Homescreen(),

      },
    );
  }
}

