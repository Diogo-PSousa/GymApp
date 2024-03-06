// ignore_for_file: depend_on_referenced_packages

import 'package:firebase_core/firebase_core.dart';
import 'package:fit_friend/DatabaseHelper.dart';
import 'package:fit_friend/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:fit_friend/MealsProvider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
  bool isSampleDataInserted = prefs.getBool('isSampleDataInserted') ?? false;
  if (!isSampleDataInserted) {
    DatabaseHelper databaseHelper = DatabaseHelper.instance;
    await databaseHelper.insertSampleData();
    prefs.setBool('isSampleDataInserted', true);
  }
  runApp(
    ChangeNotifierProvider(
    create: (context) => MealProvider(),
    child: MyApp(isLoggedIn: isLoggedIn),
  ),);
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;

  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'FitFriend',
      initialRoute: isLoggedIn ? '/home' : '/login',
      routes: routes,
    );
  }
}
