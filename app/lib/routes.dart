import 'package:fit_friend/FAQ_page.dart';
import 'package:fit_friend/Login_widget.dart';
import 'package:fit_friend/Nutrition_page.dart';
import 'package:fit_friend/ProfileScreen.dart';
import 'package:fit_friend/favorites_list_screen.dart';
import 'package:fit_friend/firebase_auth.dart';
import 'package:fit_friend/forgotpassword_widget.dart';
import 'package:fit_friend/home_page.dart';
import 'package:fit_friend/mealsList_page.dart';
import 'package:fit_friend/muscle_exercise_page.dart';
import 'package:fit_friend/signup_widget.dart';
import 'package:flutter/material.dart';


Map<String, WidgetBuilder> routes = {
  '/login': (context) => LoginWidget(auth: FirebaseAuthService()),
  '/signup': (context) => const SignUpWidget(),
  '/forgot-password': (BuildContext context) => const ForgotPasswordWidget(),
  '/home': (BuildContext context) => const HomePage(),
  '/muscleExercisePage': (BuildContext context) => const MuscleExercisePage(),
  '/FAQ': (BuildContext context) => const FAQPage(),
  '/favoritesScreen': (BuildContext context) => const FavoritesScreen(),
  '/profile': (BuildContext context) => ProfileScreen(),
  '/Nutrition': (BuildContext context) => const NutritionPage(),
  '/MealsListPage': (BuildContext context) => const MealsListPage()
};
