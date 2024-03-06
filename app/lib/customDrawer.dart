import 'package:fit_friend/FAQ_page.dart';
import 'package:fit_friend/Nutrition_page.dart';
import 'package:fit_friend/ProfileScreen.dart';
import 'package:fit_friend/favorites_list_screen.dart';
import 'package:fit_friend/muscle_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Login_widget.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: const Color(0xFFE5E4E2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const SizedBox(
            height: 150.0,
            width: 100.0,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFFE5E4E2),
              ),
              child: Text('Menu'),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.red),
              ),
            ),
            child: GestureDetector(
              child: const ListTile(
                title: Text('Profile'),
                textColor: Colors.black,
                leading: Icon(Icons.person),
              ),
              onTap: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.red),
              ),
            ),
            child: GestureDetector(
              key: const Key("Favorite_Exercises"),
              child: const ListTile(
                title: Text('Favorite Exercises'),
                textColor: Colors.black,
                leading: Icon(Icons.star_border_outlined),
              ),
              onTap: () {
                Navigator.pushNamed(context, FavoritesScreen.routeName);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.red),
              ),
            ),
            child: GestureDetector(
              key: const Key('Muscle_Exercises'),
              child: const ListTile(
                title: Text('Muscle Exercises'),
                textColor: Colors.black,
                leading: Icon(Icons.fitness_center),
              ),
              onTap: () {
                Navigator.pushNamed(context, MuscleExercisePage.routeName);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.red),
              ),
            ),
            child: GestureDetector(
              key: const Key("Nutrition page"),
              child: const ListTile(
                title: Text('Nutrition'),
                textColor: Colors.black,
                leading: Icon(Icons.restaurant),
              ),
              onTap: () {
                Navigator.pushNamed(context, NutritionPage.routeName);
              },
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 2.0, color: Colors.red),
              ),
            ),
            child: GestureDetector(
              key: const Key("FAQ_page"),
              child: const ListTile(
                title: Text('FAQ'),
                textColor: Colors.black,
                leading: Icon(Icons.question_mark_outlined),
              ),
              onTap: () {
                Navigator.pushNamed(context, FAQPage.routeName);
              },
            ),
          ),
          Expanded(
              child: Align(
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              key: const Key("logout_button"),
              child: const ListTile(
                title: Text('Log out'),
                textColor: Colors.black,
                leading: Icon(Icons.logout),
              ),
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                prefs.setBool('isLoggedIn', false);
                Navigator.pushNamedAndRemoveUntil(context,
                    LoginWidget.routeName, ModalRoute.withName('/home'));
              },
            ),
          ))
        ],
      ),
    );
  }
}
