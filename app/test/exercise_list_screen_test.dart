import 'package:flutter_test/flutter_test.dart';
import 'package:fit_friend/exercise_list_screen.dart';
import 'package:fit_friend/DatabaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:mockito/mockito.dart';
import 'package:fit_friend/fireStoreHelper.dart';

class MockFireStoreHelper extends Mock implements FireStoreHelper {
  // This class will be used to mock the FireStoreHelper
}

class MockDatabaseHelper extends Mock implements DatabaseHelper {
  // Override methods here to return mock data
  @override
  Future<List<Map<String, dynamic>>> getExercisesByMuscle(
      String muscleName) async {
    // Return mock exercise data
    return [
      {'id': 1, 'name': 'Exercise 1', 'description': 'Description 1'},
      {'id': 2, 'name': 'Exercise 2', 'description': 'Description 2'},
    ];
  }
}

void main() {
  group('Exercise List Screen tests', () {

    final firestoreHelper = MockFireStoreHelper();

    testWidgets('ExerciseListScreen shows correct muscle name',
        (WidgetTester tester) async {
      // Set up the mock database helper
      final dbHelper = MockDatabaseHelper();

      // Build the ExerciseListScreen widget
      await tester.pumpWidget(
        MaterialApp(
          home: ExerciseListScreen(
            muscleName: 'Test Muscle',
            databaseHelper: dbHelper,
            firestoreHelper: firestoreHelper,
          ),
        ),
      );


      // Find the muscle name widget
      final muscleNameFinder = find.text('Test Muscle');

      // Verify that the muscle name widget is present
      expect(muscleNameFinder, findsOneWidget);
    });
        });
}
