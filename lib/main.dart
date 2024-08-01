import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_demo/home/homescreen.dart';
import 'package:todo_demo/my_theme/my_theme_data.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_demo/provider/config_provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:todo_demo/provider/list_provider.dart';
import 'firebase_options.dart';
import 'home/list/edit_task_item.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  // options: DefaultFirebaseOptions.android or currentPlatform or ios or ext..
  Platform.isAndroid ? await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: 'AIzaSyDncz58rmN0udv-3874Wfcn6Xa3xlW0Ldc',
          appId: 'com.example.todo_demo',
          messagingSenderId: '876795203733',
          projectId: 'todo-demo-17b58') ):
  await Firebase.initializeApp();
  await FirebaseFirestore.instance.disableNetwork();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  final String? saveLango = sharedPreferences.getString('appLanguage');
  final bool? theme = sharedPreferences.getBool('theme');
  runApp(
      MultiProvider(
      providers:[
        ChangeNotifierProvider(create: (context) => ConfigProvider(
          locale: saveLango ?? 'ar', mode: theme ?? false)
        ),
        ChangeNotifierProvider(create: (context) =>ListProvider() )
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
      themeMode: provider.Theme,
      darkTheme: MyThemeData.dark,
      locale: Locale(provider.appLanguage),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: Homescreen.routeName,
      routes: {
        Homescreen.routeName: (context) => Homescreen(),
        EditTaskItem.routeName: (context) => EditTaskItem(),

      },
    );
  }
}

