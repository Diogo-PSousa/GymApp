import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fit_friend/DatabaseHelper.dart';
import 'package:mockito/mockito.dart';

void main() {
  group('Exercise', () {
    test('Exercise.fromFirestore creates Exercise object correctly', () {
      final snapshot = MockDocumentSnapshot();
      snapshot.dataResult = {
        'exerciseId': 1,
        'exerciseName': 'Exercise 1',
        'exerciseDescription': 'Description 1',
        'muscleName': 'Muscle 1',
      };

      final exercise = Exercise.fromFirestore(snapshot);

      expect(exercise.id, 1);
      expect(exercise.name, 'Exercise 1');
      expect(exercise.description, 'Description 1');
      expect(exercise.muscle_name, 'Muscle 1');
    });

    test('toMap returns the correct map', () {
      final exercise = Exercise(
        id: 1,
        name: 'Exercise 1',
        description: 'Description 1',
        muscle_name: 'Muscle 1',
      );

      final map = exercise.toMap();

      expect(map['id'], 1);
      expect(map['name'], 'Exercise 1');
      expect(map['description'], 'Description 1');
      expect(map['muscle_name'], 'Muscle 1');
    });

    test('toString returns the correct string representation', () {
      final exercise = Exercise(
        id: 1,
        name: 'Exercise 1',
        description: 'Description 1',
        muscle_name: 'Muscle 1',
      );

      final string = exercise.toString();

      expect(string, 'Exercise{id: 1, name: Exercise 1, description: Description 1, muscle_name: Muscle 1}');
    });
  });
}


class MockDocumentSnapshot extends Mock implements DocumentSnapshot {
  late Map<String, dynamic> dataResult;

  @override
  Map<String, dynamic> data() => dataResult;


}

