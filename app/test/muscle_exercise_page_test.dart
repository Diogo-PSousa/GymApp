import 'package:fit_friend/DatabaseHelper.dart';
import 'package:fit_friend/exercise_list_screen.dart';
import 'package:fit_friend/fireStoreHelper.dart';
import 'package:fit_friend/muscle_exercise_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MuscleExercisePage widget tests', () {
    test('muscle exercise list contains expected values', () {
      final muscleExercises = [
        'Chest',
        'Back',
        'Legs',
        'Biceps',
        'Triceps',
        'Shoulders',
        'Abs'
      ];

      expect(muscleExercises,
          const MuscleExercisePage().createState().muscleExercises);
    });
  });
}
