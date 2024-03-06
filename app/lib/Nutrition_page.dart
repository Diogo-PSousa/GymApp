import 'package:fit_friend/customAppBar.dart';
import 'package:fit_friend/customDrawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fit_friend/MealsProvider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class NutritionPage extends StatefulWidget {
  static const routeName = '/Nutrition';

  const NutritionPage({super.key});

  @override
  _NutritionPageState createState() => _NutritionPageState();
}

class _NutritionPageState extends State<NutritionPage> {
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Breaks'];
  //final List<List<dynamic>> _meals = [[], [], [], []];

  void _addMeal(int mealType) async {
    final result = await Navigator.pushNamed(context, '/MealsListPage');

    if (result != null) {
      final Map<String, dynamic> resultMap = result as Map<String, dynamic>;
      final meal = resultMap['meal'];
      final calculatedCalories = resultMap['calculatedCalories'];
      final newMeal = {'name': meal['name'], 'calories': calculatedCalories};

      final mealProvider = Provider.of<MealProvider>(context, listen: false);
      mealProvider.addMeal(mealType, newMeal);

      // Save the updated meals to shared preferences
      final prefs = await SharedPreferences.getInstance();
      final mealsJson = mealProvider.meals.map((list) => json.encode(list)).toList();
      await prefs.setStringList('meals', mealsJson);
    }
  }


  @override
  void initState() {
    super.initState();
    _loadMealsFromSharedPreferences();
  }

  void _loadMealsFromSharedPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final mealsJson = prefs.getStringList('meals');

    if (mealsJson != null) {
      final meals = mealsJson.map((jsonString) {
        final List<dynamic> mealList = json.decode(jsonString);
        return mealList.cast<Map<String, dynamic>>();
      }).toList();
      final mealProvider = Provider.of<MealProvider>(context, listen: false);
      mealProvider.setMeals(meals);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mealProvider = Provider.of<MealProvider>(context);
    final meals = mealProvider.meals;
    num totalCalories = 0;
    for (int i = 0; i < meals.length; i++) {
      for (int j = 0; j < meals[i].length; j++) {
        totalCalories += meals[i][j]['calories'];
      }
    }
    return Scaffold(
      backgroundColor: const Color(0xFFE2E2E2),
      appBar: const CustomAppBar(),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(
                top: 15.0,
                bottom: 3.0,
                left: 15.0,
                right: 15.0,
              ),
              child: Text(
                'Nutrition',
                style: TextStyle(
                  fontSize: 30.0,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _showConfirmationDialog,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: const Text('New Day'),
                ),
              ),
            ),
            for (int i = 0; i < _mealTypes.length; i++)
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        _mealTypes[i],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                    ),
                    Center(
                      child: ElevatedButton(
                        key: Key(_mealTypes[i]),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        onPressed: () {
                          _addMeal(i);
                        },
                        child: const Text('Add'),
                      ),
                    ),
                    for(int j = 0; j < meals[i].length;j++)
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(meals[i][j]['name']),
                                  Text(
                                    'Calories: ${meals[i][j]['calories']}',
                                    style: const TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  //meals[i].removeAt(j);
                                  mealProvider.removeMeal(i, j);
                                });
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            const SizedBox(height: 20.0), // added SizedBox for spacing
            // total calorie count box
            Container(
              padding: const EdgeInsets.all(16.0),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Text(
                'Total Calories: $totalCalories',
                style: const TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showConfirmationDialog(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('New Day'),
          content: const Text('Are you ready for a new day?'),
          actions: [
            TextButton(
              onPressed: () {
                // Remove all meals
                Provider.of<MealProvider>(context, listen: false).clearMeals();
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Yes', style: TextStyle(color: Colors.red),),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('No', style: TextStyle(color: Colors.red),),
            ),
          ],
        );
      },
    );
  }
}