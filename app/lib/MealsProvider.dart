import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class MealProvider extends ChangeNotifier {
  final List<List<dynamic>> _meals = [[], [], [], []];

  List<List<dynamic>> get meals => _meals;

  void setMeals(List<List<Map<String, dynamic>>> meals) {
    _meals.clear();
    _meals.addAll(meals);
    notifyListeners();
  }

  void addMeal(int mealType, Map<String, dynamic> mealData) {
    _meals[mealType].add(mealData);
    notifyListeners();
  }

  void removeMeal(int mealType, int index) {
    _meals[mealType].removeAt(index);
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      final mealsJson = _meals.map((list) => json.encode(list)).toList();
      prefs.setStringList('meals', mealsJson);
    });
  }

  void clearMeals() {
    _meals.forEach((mealList) => mealList.clear());
    notifyListeners();

    SharedPreferences.getInstance().then((prefs) {
      prefs.remove('meals');
    });
  }
}